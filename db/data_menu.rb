module DATA_DEF
  tt={
  page: "页面", 
  user: "用户", 
  article: "文章",
  type: "文章类型", 
  classified: "专栏",  
  document: "分类文档",      
  news: "新闻", 
  notice: "通知", 
  news_notice: "新闻和通知",   
  slide: "幻灯通知",    
  event: "事件", 
  widget: "积木",
  template: "模板",
  customer: "成功案例",  
  brief: "功能介绍", 
  help: "帮助文档",   
  about_us: "关于我们",   

  media: "多媒体",  
  gallery: "影集", 
  photo: "照片",

  sysadm: "系统管理",
  sys_setting: "系统设置",
  user_adm: "用户管理",   
  role: "角色", 
  page_adm: "页面管理",   
  viewadm: "窗口管理", 
  funlife: "精彩人生",
  health: "健康生活",    
  home: "主页",
  index: "主页",  
  menu: "菜单",  
  all: "所有",
  group: "用户群",   
  admin: "管理员", 
  dev: "开发者",  
  user: "用户",
  new: "新建", 
  task: "协调活动&任务" 
 
  }

DATA_MENU={

menu:[
  # Create top level menus 
  # Don't change the order of top menus
  # The orders is their ids
  # The children menu will depend on their order/id
  # We cannot rely on order_by 
  # because it can be modified in UI
    {name:tt[:page_adm],order_by:50}, #1        
    {name:tt[:sysadm],order_by:60},  #2
    {name:'Top level Menu 3',active:false}, #3
    {name:'Top level Menu 4',active:false}, #4    
    {name:tt[:user_adm],order_by:30}, #5
    {name:tt[:task],order_by:20},    #6
    {name:tt[:index],order_by:10},  #7  
    {name:tt[:customer],order_by:40},#8    
    {name:tt[:about_us],order_by:70},#9     
    {name:tt[:help],order_by:80},#10          
    {name:'Top level Menu 11',active:false},
    {name:'Top level Menu 13',active:false},  
    {name:'Top level Menu 14',active:false},    
    {name:'Top level Menu 15',active:false}, 
    {name:'Top level Menu 16',active:false}, 
    {name:'Top level Menu 17',active:false},
    {name:'Top level Menu 18',active:false},  
    {name:'Top level Menu 19',active:false},  
    {name:'Top level Menu 20',active:false}, 

    {pid:1,name:tt[:article],url:'/admin/articles'},
    {pid:1,name:tt[:type],url:'/admin/types'},    
    {pid:1,name:tt[:menu],url:'/admin/menus'},
    {pid:1,name:tt[:page],url:'/admin/wpages'},     
    {pid:1,name:tt[:widget],url:'/admin/widgets'},
    {pid:1,name:tt[:template],url:'/admin/templates'},
    {pid:2,name:tt[:sys_setting],url:'/admin/settings'},
    {pid:2,name:tt[:viewadm],url:'/admin/view_adms'},
    {pid:5,name:tt[:user],url:'/admin/users'}, 
    {pid:5,name:tt[:group],url:'/groups'},         
    {pid:5,name:tt[:role],url:'/roles'},
    # pid:1, defined in wpage
    {pid:7,name:tt[:index],url:'/index'},    
    {pid:6,name:'Task',url:'/tasks'},  
    {pid:6,name:'Task Types',url:'/task_types'},    
    {pid:6,name:'Task History',url:'/task_hists'},  
    {pid:6,name:'Task Times',url:'/task_times'}, 

    {pid:8,name:tt[:customer],url:"/tasks"},    


    {pid:9,name:tt[:news_notice],url:'/news/all'},#classified                 
    {pid:9,name:tt[:news],url:'/news/news'},   
    {pid:9,name:tt[:notice],url:'/news/notice'},  
    {pid:9,name:tt[:event],url:'/admin/events?scope=slide'}, 
    {pid:9,name:tt[:funlife],url:"/news/#{tt[:funlife]}"},#funlife  
    {pid:10,name:tt[:brief],url:"/papers/index"}, 
    {pid:10,name:tt[:help],url:"/papers/help"},     
  ],  
}
end