class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
        #,:omniauthable, :omniauth_providers => [:digitalocean]

  # Setup accessible (or protected) attributes for your model  
  #attr_accessible :email, :password, :password_confirmation
  has_many :authentications           
  has_many :user_groups
  has_many :groups,:through=>:user_groups  
  before_save :set_default
  before_validation :password_generation
  attr_accessor :gid,:rid,:provider     
  def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
      end
  end
  def self.find_or_create(email,vname=nil)
    find_by_email(email) || create_with_email(email,vname)
  end  
  def self.create_with_email(email,vname)
    create! do |user|
      user.email = email
      user.vname = vname      
    end
  end  
  def join_group(group_id,rid=6) 
    uid=self.id
    UserGroup.join_user_group_role(uid,group_id,rid)
  end 
  def leave_group(group_id) 
      UserGroup.delete_all(user_id:self.id,group_id:group_id)
  end 
  def role_of_group(group_id)
    return '' unless group_id
    ugs=UserGroup.by_user_group(self.id,group_id) 
    if ugs.any? 
      role_id=ugs.first.role_id
      role=Role.find(role_id)
      return role.name
    else
      return ''
    end 
  end        

  scope :by_email, lambda {|email|
    where(email:email)
  }
  scope :by_group, lambda {|id|
    joins(:user_groups).merge(UserGroup.by_group(id))
  }  
  scope :by_qq, lambda {|qq|
    email=qq+'@qq.com'
    where(email:email)
  }
  def password_generation
    self.password||=Devise.friendly_token.first(8)
  end
  def set_default
    self.active=true if self.active.nil?
    self.vname||=self.get_vname
  end 
    
  def self.find_or_add_by_qq(qq)
    email=qq.to_s+'@qq.com'    
    u=self.by_email(email).first
    if u.nil? 
      u=self.create!(email:email)
    end
    return u
  end
  def get_vname
    self.fname||self.email.split('@').first
  end
  def group_list
    self.groups.map{|x|x.vname}.join(',')
  end
  def admin?
    self.id && self.id<2
  end
  def AdminOfUser?(uid)
    return false if self.id.nil? # A temp user
    return false if uid.nil? || self.id.nil?    
    # Both self.id and uid defined
    ug=UserGroup.by_user(uid)
    ug=ug.by_user(self.id)
    ug=ug.by_role(1) # a=admin
    ug.any?
  end
  def in_group?(id)

  end  
  def AdminOfGroup(gid)
    ug=UserGroup.by_group(gid)
    ids=ug.map{|x|x.id}
    ids.include?(self.id)
  end
  def brief
    {id:id,vname:vname}
  end    
  def self.guest()
    self.find(2)
  end 
end