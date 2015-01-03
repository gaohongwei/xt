class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :user_groups
  has_many :groups,:through=>:user_groups  
  before_save :set_default
  attr_accessor :gid,:rid 
  def self.guest()
    self.find(2)
  end 
  def set_default
    self.active=true if self.active.nil?
    self.vname||=self.get_vname
  end         
  def get_vname
    self.fname||self.email.split('@').first
  end
  def group_list
    self.groups.map{|x|x.vname}.join(',')
  end
  def admin?
    self.id && self.id<5
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
  def AdminOfGroup(gid)
    ug=UserGroup.by_group(gid)
    ids=ug.map{|x|x.id}
    ids.include?(self.id)
  end
  def brief
    {id:id,vname:vname}
  end    

end