require 'open-uri'

class Application::NewsController < ApplicationController
  include ApplicationHelper
  #caches_action :index, :cache_path => Proc.new { |c| c.params }

  def index
    @seo = { url: "http://whxzyz.heroku.com/news" }
    @title = 'News '
    @description = 'News, press releases, and media resources from Five9, the leader in the cloud contact center software industry.'
    @seo['seo_title'] = @title
    @seo['og_title'] = @title
    @seo['seo_description'] = @description
    @seo['og_description'] = @description

    @header = Setting.news_header

    page = params[:page] || 1
    per_page = 10

    @filter = params[:type]||tt('news') 
    tts_news_notice=tts('news&notice','&',true)
    #params[:tts]=tts_news_notice
    if [tts_news_notice,tt('news'),tt('notice'),'news','notice'].include?(@filter)  || tts_news_notice == @filter
      cookies[:filter_group]=[tt('news'),tt('notice')]
      tags=[tt(@filter)]
      @articles = Article.tagged_with(tags,:any => true).order('published_on desc').page(page).per(10)
    else 
      # We list all

      tags=Article.tag_counts.map{|x|x.name}
      params[:yyy]=@filter  
      tags_del=Setting[:exclude_page_type] 
      params[:del]=tags_del
      tags_del.split(',').each do |tag|
        #tags.delete(tag)
      end 
      cookies[:filter_group]=tags         
      tags=[tt(@filter)]                
      params[:yyy]=@filter      
      params[:tags]=tt(@filter)
      @articles = Article.tagged_with(tags,:any => true).order('published_on desc').page(page).per(10)          
    end
  end
  def slideshow
    permalink = params[:permalink]
    article = Article.find(permalink)
    content = article.content 
    #content=content.gsub("\r\n","\n").gsub("br /","\n")  
    content=content.gsub("<br />","`") 
    @ar=[]
    @bottom_string=article.title

    page = Nokogiri::HTML(content)  
    page.css('p').each do |p|
      #p.css("br").each do |e|
      content=p.content
      #content=content.gsub("<br />","\n") 
      #content=content.gsub("<br />","-")
      content.split('`').each do |e|
        @ar<<e
      end     
    end 
  end
  def show
    permalink = params[:permalink]

    params[:cookie]=cookies[:filter_group]
    @article = Article.find_by_permalink(permalink)

    if @article
      @page = Wpage.find_by_url("news/#{permalink}")

      @seo = { url: "http://whxzyz.heroku.com/news/news-releases/#{@article.permalink}" }
      @title = 'News'
      @description = ''#@article.tagline
      @seo['seo_title'] = @title
      @seo['og_title'] = @title
      @seo['seo_description'] = @description
      @seo['og_description'] = @description
    end

    if @article.nil? && @page
      render 'application/pages/show'
    end

    raise ActiveRecord::RecordNotFound if @article.nil? && @page.nil?
  end
end
