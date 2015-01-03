module DATA_DEF
DATA_SETTINGS={
setting:[
# action_scope format
# act,scope,label,nested_res=action_scope.split(':')
# show:article:tye article list:articles
# articles: nested resources
#
# Action not support
# new:false, edit:false, show:false
# cols format
# column:r, for single selection
# column:c, for multiple selection
# column:l, not working now
# cols:"name;active;dad:r:menus.top;wpage:r"
# column:dad, type:rdio, data:menus.top
#
    {var:'contact_info',value:''},
    {var:'browser_title',value:'协调网'},
    {var:'body_header',value:'协调网'},     
    {var:'per_page',value:'20'}, 
    # Control delete/edit action here or in view+adm?
    {var:'delete_on_index',value:'1'}, # have delete action on index? 
    {var:'edit_on_index',value:'1'}, # have edit action on index?        
    {var:'exclude_page_type',value:'news,notice'},     
    {var:'news_header_title',value:'News(XinWen)'},
    {var:'news_header_description',value:'News(XinWen)'},
    {var:'news_header_background_url',value:nil},
    {var:'news_header_read_more_url',value:'/news'},

    {var:'og_description',value:''},
    {var:'og_image_url',value:''},
    {var:'og_title',value:''},
    {var:'og_type',value:''},
    {var:'seo_description',value:''},
    {var:'seo_title',value:''},    
  ]
}
end