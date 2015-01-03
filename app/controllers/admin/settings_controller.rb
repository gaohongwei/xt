class Admin::SettingsController < AdminController
  #after_filter  :bust_news_cache, only: [:update]
  after_filter :update_cache, only: [:update]
  def show0
    render json: Setting.all
  end

  def update_cache
    if params[:setting]
      params[:setting].each do |key, value|
        Setting[key] = value unless Setting[key].nil?
      end
    end
  end
  private
    def get_params
      params.require(:setting).permit!
    end  
end