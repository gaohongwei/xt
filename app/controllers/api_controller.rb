class ApiController < ApplicationController
  before_filter :authenticate_user_or_qq!
end