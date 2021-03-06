require 'omniauth/strategies/oauth2'
require 'base64'
require 'openssl'
require 'rack/utils'
require 'uri'
#gem 'omniauth-linkedin-oauth2' 
#'linkedin-oauth2' 'omniauth-linkedin'
#gem 'omniauth-qq-connect' # gem 'omniauth-qq-oauth2'
#gem 'omniauth-facebook'
#gem 'omniauth-google-oauth2'
    class Oauth2Facebook < OmniAuth::Strategies::OAuth2
      class NoAuthorizationCodeError < StandardError; end
      class UnknownSignatureAlgorithmError < NotImplementedError; end

      DEFAULT_SCOPE = 'email'
      SUPPORTED_ALGORITHM = 'HMAC-SHA256'

      option :name, 'facebook'
      option :client_options, {
        :site => 'https://graph.facebook.com',
        :authorize_url => "https://www.facebook.com/dialog/oauth",
        :token_url => '/oauth/access_token'
      }

      option :token_params, {
        :parse => :query
      }

      option :access_token_options, {
        :header_format => 'OAuth %s',
        :param_name => 'access_token'
      }

      option :authorize_options, [:scope, :display, :auth_type]

      uid { raw_info['id'] }

      info do
        prune!({
          'nickname' => raw_info['username'],
          'email' => raw_info['email'],
          'name' => raw_info['name'],
          'first_name' => raw_info['first_name'],
          'last_name' => raw_info['last_name'],
          'image' => image_url(uid, options),
          'description' => raw_info['bio'],
          'urls' => {
            'Facebook' => raw_info['link'],
            'Website' => raw_info['website']
          },
          'location' => (raw_info['location'] || {})['name'],
          'verified' => raw_info['verified']
        })
      end

      extra do
        hash = {}
        hash['raw_info'] = raw_info unless skip_info?
        prune! hash
      end

      def raw_info
        @raw_info ||= access_token.get('/me', info_options).parsed || {}
      end

      def info_options
        params = {:appsecret_proof => appsecret_proof}
        params.merge!({:fields => options[:info_fields]}) if options[:info_fields]
        params.merge!({:locale => options[:locale]}) if options[:locale]

        { :params => params }
      end

      def callback_phase
        with_authorization_code! do
          super
        end
      rescue NoAuthorizationCodeError => e
        fail!(:no_authorization_code, e)
      rescue UnknownSignatureAlgorithmError => e
        fail!(:unknown_signature_algorithm, e)
      end

      # NOTE If we're using code from the signed request then FB sets the redirect_uri to '' during the authorize
      #      phase and it must match during the access_token phase:
      #      https://github.com/facebook/facebook-php-sdk/blob/master/src/base_facebook.php#L477
      def callback_url
        if @authorization_code_from_signed_request_in_cookie
          ''
        else
          options[:callback_url] || super
        end
      end

      def access_token_options
        options.access_token_options.inject({}) { |h,(k,v)| h[k.to_sym] = v; h }
      end

      # You can pass +display+, +scope+, or +auth_type+ params to the auth request, if you need to set them dynamically.
      # You can also set these options in the OmniAuth config :authorize_params option.
      #
      # For example: /auth/facebook?display=popup
      def authorize_params
        super.tap do |params|
          %w[display scope auth_type].each do |v|
            if request.params[v]
              params[v.to_sym] = request.params[v]
            end
          end

          params[:scope] ||= DEFAULT_SCOPE
        end
      end

      protected

      def build_access_token
        super.tap do |token|
          token.options.merge!(access_token_options)
        end
      end

      private

      def signed_request_from_cookie
        @signed_request_from_cookie ||= raw_signed_request_from_cookie && parse_signed_request(raw_signed_request_from_cookie)
      end

      def raw_signed_request_from_cookie
        request.cookies["fbsr_#{client.id}"]
      end

      # Picks the authorization code in order, from:
      #
      # 1. The request 'code' param (manual callback from standard server-side flow)
      # 2. A signed request from cookie (passed from the client during the client-side flow)
      def with_authorization_code!
        if request.params.key?('code')
          yield
        elsif code_from_signed_request = signed_request_from_cookie && signed_request_from_cookie['code']
          request.params['code'] = code_from_signed_request
          @authorization_code_from_signed_request_in_cookie = true
          # NOTE The code from the signed fbsr_XXX cookie is set by the FB JS SDK will confirm that the identity of the
          #      user contained in the signed request matches the user loading the app.
          original_provider_ignores_state = options.provider_ignores_state
          options.provider_ignores_state = true
          begin
            yield
          ensure
            request.params.delete('code')
            @authorization_code_from_signed_request_in_cookie = false
            options.provider_ignores_state = original_provider_ignores_state
          end
        else
          raise NoAuthorizationCodeError, 'must pass either a `code` (via URL or by an `fbsr_XXX` signed request cookie)'
        end
      end

      def prune!(hash)
        hash.delete_if do |_, value|
          prune!(value) if value.is_a?(Hash)
          value.nil? || (value.respond_to?(:empty?) && value.empty?)
        end
      end

      def parse_signed_request(value)
        signature, encoded_payload = value.split('.')
        return if signature.nil?

        decoded_hex_signature = base64_decode_url(signature)
        decoded_payload = MultiJson.decode(base64_decode_url(encoded_payload))

        unless decoded_payload['algorithm'] == SUPPORTED_ALGORITHM
          raise UnknownSignatureAlgorithmError, "unknown algorithm: #{decoded_payload['algorithm']}"
        end

        if valid_signature?(client.secret, decoded_hex_signature, encoded_payload)
          decoded_payload
        end
      end

      def valid_signature?(secret, signature, payload, algorithm = OpenSSL::Digest::SHA256.new)
        OpenSSL::HMAC.digest(algorithm, secret, payload) == signature
      end

      def base64_decode_url(value)
        value += '=' * (4 - value.size.modulo(4))
        Base64.decode64(value.tr('-_', '+/'))
      end

      def image_url(uid, options)
        uri_class = options[:secure_image_url] ? URI::HTTPS : URI::HTTP
        url = uri_class.build({:host => 'graph.facebook.com', :path => "/#{uid}/picture"})

        query = if options[:image_size].is_a?(String)
          { :type => options[:image_size] }
        elsif options[:image_size].is_a?(Hash)
          options[:image_size]
        end
        url.query = Rack::Utils.build_query(query) if query

        url.to_s
      end

      def appsecret_proof
        @appsecret_proof ||= OpenSSL::HMAC.hexdigest(OpenSSL::Digest::SHA256.new, client.secret, access_token.token)
      end
    end