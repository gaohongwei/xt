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
  DATA_PAGE={
    type:[
        {name:tt[:news],description:tt[:news]}, 
        {name:tt[:notice],description:tt[:notice]},   
        {name:tt[:slide],description:tt[:slide]}      
      ],
    wpage:[                   
        {menu_pid:1,title:tt[:index],url:'/index',widget_id:1},
      ],      
############## Widget  
    widget:[  
        {name: 'Invitation Letter', description: 'Invitation Letter', 
          content: '<%= show_article(1) %>'
        }  
    ],
############## Event
event:[  
    {title: "<p>热列庆祝协调网</p><p>隆重推出第一版</p>", 
    description: 
'<font color="red"><center>
<p>热列庆祝协调网站第一版隆重推出</p>
</center></font>'
    }, 
    {title: "<p>协调网<p><p>将邀请国内外相关领域的专家评审</p>", 
    description: 
'<font color="red"><center>
<p>将邀请相关领域的专家评审</p>
</center></font>'
    },  
  ],  
############## Article 
article:[  
    {title: '功能介绍',
    tag_list: '帮助', 
    permalink:'index',
    content:'
<p>当我们策划一项活动时， 可能要涉及到很多人的不同意见和想法，包括不同的时间，不同的方法等。为解决分歧，寻求共识，我们就不得不开会。</p> 
<p>本网站提供一个的方案，它提供一个平台，起到收集、协调、整合意见的作用，具体流程如下：</p> 
<ul> 
<li>活动发起人首先提出一个方案或设想；</li> 
<li>并通过电子媒体邀请、通知相关的人员；</li> 
<li>受邀请的人员对方案在线进行修改或应答；</li> 
<li>将更新通知相关的人员；</li> 
<li>如此反复；</li> 
<li>直到最后达到最大共识；</li> 
<li>最后的版本就是共识版。</li> </ul> 

当然，最后可能还是需要组织者的决断。</p> 
<p>该网站适用于朋友间的活动协调，如同学聚会，朋友聚餐，结伴旅行，联欢会节目表，也可用公司内的技术方案要点讨论。</p>'
    },
    {title: '使用手册',
    tag_list: '帮助', 
    permalink:'help',
    content:"
<p>使用手册</p> 
<p>第一步：登陆。您可以使用guest@gmail.com登陆，密码为password。</p> 
<p>用公用用户可以收集信息，但统计数据就没意义，因为是同一用户。</p>
<p>建议您注册自己的用户名。</p>
<p>第二步：依次选择‘协调活动&任务’、‘所有’菜单，新建并选择（点击）您自己的活动&任务。您将进入‘显示:活动、任务‘页面。</p> 
<p>第三步：在’显示:活动、任务‘页面下部，点击‘输入和选择’按钮，您将进入‘活动、任务输入和选择’页面。</p> 
<p>第四步：在页面移动鼠标，您将看到动态提示。</p> 
"
    },        
    {title: '视频教程',
    tag_list: '帮助', 
    permalink:'vhelp',
    content:"
<p>视频教程</p> 
<p>第一节：待加</p> 
<p>第二节：待加</p> 
"
  },          
  ],              
}
end
