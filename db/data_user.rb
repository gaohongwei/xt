module DATA_DEF
xzyz='your group name'
PWD='password'

READ='read'
WRITE='write'
ADMIN='admin'
OWNER='owner'
CODER='coder'
PENDING='pending'
INVITED='invited'
DENIED='denied'
DATA_USER={
role:[   
    {name:OWNER,  description:OWNER},#1   
    {name:ADMIN,  description:ADMIN},#2 
    {name:CODER, description:CODER}, #3   
    {name:WRITE,  description:WRITE}, #4
    {name:READ,   description:READ}, #5
    {name:PENDING,description:PENDING},#6
    {name:INVITED,description:INVITED},#7 
    {name:DENIED, description:DENIED},#8        
  ],    
group:[  
    {name: 'Web Master', description: 'Web Admin'}, #1
    {name: 'Web Guest',  description: 'Web Guest'}, #1 
  ],  
user:[ # gid=group_id rid=role_id
    {vname:'admin', email:'admin@gmail.com',password:PWD,gid:1,rid:1},  
    {vname:'guest1',email:'guest1@gmail.com',password:'password',
        gid:1,rid:6},
    {vname:'guest2',email:'guest2@gmail.com',password:'password',
        gid:1,rid:6},  
    {vname:'guest3',email:'guest3@gmail.com',password:'password',
        gid:1,rid:6},               
  ]
}
end