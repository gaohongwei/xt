class Admin::ArticlesController < AdminController
  private
    # Use callbacks to share common setup or constraints between actions.
    # Only allow a trusted parameter "white list" through.
    def get_params
      #params.require(:article).permit(:title, :permalink, :content, :source_site, :introtext, :type_id, :order_by, :searchable, :created_by, :edited_by, :published_by, :published_on, :user_id)
      params.require(:article).permit!

    end
    def after_save
      if @obj.tag_list.nil? || @obj.tag_list.empty?
        @obj.tag_list=tt('non_classified') 
      else
        #@obj.tag_list=@obj.tag_list.tr(' ',',')         
      end  
      @obj.save!       
    end 
    #def search_col
      #Admin::Article.column_names[1]
    #end     
end  