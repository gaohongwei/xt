module DATA_DEF
xzyz='your group name'
PWD='password'
ADMIN='Admin'
OWNER='Owner'
DEVELOPER='Developer'
EDITOR='Editor'
READER='User'
PENDING='Pending'
DATA_USER={
role:[   
    {name:OWNER, description:OWNER},#1   
    {name:ADMIN, description:ADMIN},#2 
    {name:DEVELOPER, description:DEVELOPER}, #3   
    {name:EDITOR, description:EDITOR}, #4
    {name:READER, description:READER}, #5
    {name:PENDING,description:PENDING},#6
  ],    
group:[  
    {name: 'Web Master', description: 'Web Admin'}, #1
    {name: 'Web Guest',  description: 'Web Guest'}, #1 
    #{name: '8104班', description: xzyz,pid:2}, 
  ],  
user:[ # gid=group_id rid=role_id
    {vname:'admin', email:'admin@gmail.com',password:PWD,gid:1,rid:1},
    {vname:'guest',email:'guest@gmail.com',password:'password',
        gid:1,rid:6},
  ]
}
end