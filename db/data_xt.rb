module DATA_DEF
DATA_XT={ 
############## Task Type
#确定时间，寻找共同时间，用户选择时间段
#选择投票统计，针对现有选项投票，用户选择是或不是
#打分，针对现有选项打分，用户输入分数
#民调，包括投票，打分,
#信息收集，用户输入文字，可以选择投票统计
task_type:[ 
    { name:'确定时间',
        description:'寻找共同时间'
    },
    { name:'选择内容',
        description:'用户在现有的选项中选择'
    },   
    { name:'收集内容',
        description:'用户可增加内容'
    }, 
    { name:'收集、选择内容',
        description:'用户可选择、增加内容'
    },      
    { name:'意见反馈、打分',
        description:'发表意见'
    },      
    { name:'民调',
        description:'民调'
    },            
],
task:[ 
    { name:'协调网框架版，意见收集',
        description:'针对协调网框架版，收集意见。',user_id:2,active:true,public:true
    },
    { name:'2015年聚会策划',
        description:'征集2015年聚会策划',user_id:2,active:true,public:true
    },
    { name:'新洲一中同学会画册第一稿FIT：反馈',
        description:'新洲一中同学会画册第一稿FIT，意见收集',user_id:2,active:true,public:true
    },
    { name:'优点',
        description:'意见收集',user_id:2,active:true,pid:3
    },
    { name:'更正',
        description:'意见收集',user_id:2,active:true,pid:3
    },
    { name:'不足之处',
        description:'意见收集',user_id:2,active:true,pid:3
    },  
    { name:'遗漏项目',
        description:'意见收集',user_id:2,active:true,pid:3
    },         
    ],
}
end