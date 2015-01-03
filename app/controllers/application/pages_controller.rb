class Application::PagesController < ActionController::Base 
  def show
    page_url = url = params[:url]
    page_url = 'home' if url.nil?||url.empty?
    page = Wpage.by_url(url) # This is array
    #can_view_page = @page && @page.widget && ( @page.published || (current_user && params[:preview]) )
    #raise ActiveRecord::RecordNotFound unless can_view_page
    if  page.nil? || page.empty?
      redirect_to root_url  
      error="#{url} doesn't exist;will be redircted."
      logger.debug error       
    else         
      widget=page.first.widget
      if widget
        partial=widget.get_partial()
        #ender :partial=>partial,:layout => false
        render :partial=>partial,layout:'application',:locals =>{id:widget.id},:layout => "pages" 
      else
        redirect_to '/'+url
      end

    end
  end

  def sitemap
    @page = Page.where(url: "sitemap").first
    raise ActiveRecord::RecordNotFound unless @page and @page.widget

    @seo = { url: "http://five9.com/sitemap" }
    @title = 'Site Map | Five9'
    @description = 'Site map for the Five9 corporate website, providing access to essential pages on the website.'
    @seo['seo_title'] = @title
    @seo['og_title'] = @title
    @seo['seo_description'] = @description
    @seo['og_description'] = @description
  end

  def stylesheet
    url = params[:url] || ''
    url.gsub!(/.css$/, '')
    url = '' if url == 'index'
    @page = Page.where(url: url).first
    raise ActiveRecord::RecordNotFound unless @page and @page.widget

    render text: @page.widget.css.html_safe, content_type: Mime::CSS
  end
end
