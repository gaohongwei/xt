module DATA_DEF
DATA_VADM={ 
view_adm:[
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
    {name:'view_adm',action_scope:'index',
      cols:"name;action_scope;cols;caps",
      caps:"name;action;cols;caps"
    },
    {name:'view_adm',action_scope:'show',
      cols:"name;action_scope;cols;caps",
      caps:"name;action;cols;caps"      
    },
    {name:'view_adm',action_scope:'edit',
      cols:"name;action_scope;cols;caps",
      caps:"name;action;cols;caps"      
    },
############## WPage View       
    {name:'wpage',action_scope:'edit',
      cols:"url;title;widget:r;menus:c",
      caps:"url;title;widget;menu"
    },
    {name:'wpage',action_scope:'index',
      cols:"url;title;widget.name;menu_list",
      caps:"url;title;widget;menu"
    },  
    {name:'wpage',action_scope:'show',
      cols:"url;title;widget.name;menu_list",
      caps:"url;title;widget;menu"      
    },  
############## Media View 
    {name:'medium',action_scope:'index',
      cols:"title;alt_title;description;item",
      caps:"title;alt_title;description;item"
    },
    {name:'medium',action_scope:'index:slide',
      cols:"name;avatar",
      caps:"name;avatar"
    },     
    {name:'medium',action_scope:'show',
      cols:"name;user_id;avatar_file_name;avatar_content_type;avatar_file_size;avatar_updated_at",
      caps:"name;user_id;avatar_file_name;avatar_content_type;avatar_file_size;avatar_updated_at",
    },
    {name:'medium',action_scope:'edit',
      cols:"title;alt_title;description;item;galleries:c",
      caps:"title;alt_title;description;item;galleries"
    },
############## Gallery View 
    {name:'gallery',action_scope:'index',
      cols:"name;description",
      caps:"name;description"
    },
    {name:'gallery',action_scope:'edit',
      cols:"name;description;media:c",
      caps:"name;description;media"
    },
    {name:'gallery',action_scope:'show',
      cols:"name;description;media:c",
      caps:"name;description;photo"
    }, 
  # act,scope,label,nested_res=action_scope.split(':')    
    {name:'gallery',action_scope:'show:medium:gallery medium list:media',
      cols:"name;description;media:c",
      caps:"name;description;photo"
    },  
############## Task View 
# act,scope,label,nested_res=action_scope.split(':')
    {name:'task',action_scope:'index',
      cols:"name;description;user.name;public",  
      caps:"name;description;owner;public"         
    },  
    {name:'task',action_scope:'show'},      
    {name:'task',action_scope:'show:count'},          
    {name:'task',action_scope:'show:option:user_input'}, 
    {name:'task',action_scope:'edit'      
    },           
    #{name:'task',action_scope:'index:tree'},      
############## Menu View     
    {name:'menu',action_scope:'index',
      cols:"name;title;url;parent.name;active",
      caps:"name;title;url;parent;active"
    },   
    {name:'menu',action_scope:'index:tree'
    },      
    {name:'menu',action_scope:'new:false'
    },            
    {name:'menu',action_scope:'show',
      cols:"name;title;url;order_by;parent.name;active",
      caps:"name;title;url;order_by;parent;active"
    },
    {name:'menu',action_scope:'edit',
      # dad is a checkbox, collection=Menu.top
      cols:"name;active;dad:r:menus.top;wpage:r",
      caps:"name;active;parent;wpage"
    },
########## Template View
    {name:'template',action_scope:'index',
      cols:"name;description",
      caps:"name;description"
    }, 
    {name:'template',action_scope:'show',
      cols:"name;description;content",
      caps:"name;description;content"
    },   
    {name:'template',action_scope:'edit',
      cols:"name;description;content",
      caps:"name;description;content"
    },                   
    ########## Widget View
    {name:'widget',action_scope:'index',
      cols:"name;description;ancestry;parent.name",
      caps:"name;description;ancestry;parent"
    }, 
    {name:'widget',action_scope:'index:tree',
      cols:"name;description;ancestry;parent.name",
      caps:"name;description;ancestry;parent"
    },     
    {name:'widget',action_scope:'show',
      cols:"name;description;content;ancestry;parent.name",
      caps:"name;description;content;ancestry;parent"
    }, 
    {name:'widget',action_scope:'edit',
      cols:"name;description;content;dad:r;kids:c;template:r",
      caps:"name;description;content;dad;children;Select a template to fill in the view"
    },
########## Article
    {name:'article',action_scope:'index',
      cols:"title;tag_list",
      caps:"title;tag_list"
    }, 
    {name:'article',action_scope:'index:slide',
      cols:"title;type.name",
      caps:"title;type"
    },     
    {name:'article',action_scope:'edit',
      cols:"title;tag_list;content;source_site;introtext;type:r",
      caps:"title;tag_list;content;source_site;introtext;type"
    },     
    {name:'article',action_scope:'show',
      cols:"title;tag_list;source_site;introtext;created_by;edited_by;published_by;published_on;user_id;content",
      caps:"title;tag_list;source_site;introtext;created_by;edited_by;published_by;published_on;user_id;content"
    },
    {name:'article',action_scope:'show:content'},
    {name:'type',action_scope:'index',
      cols:"name;description",
      caps:"name;description"
    },   
# act,scope,label,nested_res=action_scope.split(':')       
    {name:'type',action_scope:'show:article:tye article list:articles'
    },  # label='group article list'    
    {name:'type',action_scope:'show',
      cols:"name;description",
      caps:"name;description"
    }, 
    {name:'type',action_scope:'edit',
      cols:"name;description",
      caps:"name;description"
    },           
########## Event
    {name:'event',action_scope:'index',
      cols:"title;description;date;location;active",
      caps:"title;description;Date;location;active"
    }, 
    {name:'event',action_scope:'index:slide'},    
    {name:'event',action_scope:'edit',
      cols:"title;description:text;location;date;url;reg_url;active",
      caps:"title;description;location;Date;url;reg_url;active"
    }, 
    {name:'event',action_scope:'show',
      cols:"title;description;location;date;url;reg_url;active",
      caps:"title;description;location;Date;url;reg_url;active"
    },  
########## User
    {name:'user',action_scope:'index',
      cols:"email;name;vname;cell;qq;wechat;other;groups.first.name;active",
      caps:"email;name;vname;cell;qq;wechat;other;group;active"
    }, 
    {name:'user',action_scope:'edit',
      cols:"name;vname;email;cell;qq;wechat;other;active;groups:c",
      caps:"name;vname;email;cell;qq;wechat;other;active;groups"
    },
    {name:'user',action_scope:'show',
      cols:"name;vname;email;cell;qq;wechat;other;active;group_list",
      caps:"name;vname;email;cell;qq;wechat;other;active;groups"
    },
########## Group
    {name:'group',action_scope:'index',
      cols:"name;description;active",
      caps:"name;description;active"
    },
# act,scope,label,nested_res=action_scope.split(':')    
    {name:'group',action_scope:'show:user:group user list:users',
    }, # label='group user list'
    {name:'group',action_scope:'show',
      cols:"name;description;active;user_list",
      caps:"name;description;active;users"
    }, 
    {name:'group',action_scope:'edit',
      cols:"name;description;active;users:c",
      caps:"name;description;active;users"
    },               
  ]
}
end