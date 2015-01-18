class UserGroup < ActiveRecord::Base
  belongs_to :group
  belongs_to :user  

  scope :by_user,lambda {|id|
    where(user_id:id)  
  }
  scope :by_group,lambda {|id|
    where(group_id:id)  
  }  
  scope :by_user_group,lambda {|uid,gid|
    where(user_id:uid,group_id:gid)  
  }  
  scope :by_role,lambda {|id|
    where(role_id:id)  
  }  
  scope :by_user_role,lambda {|uid,rid|
    where(user_id:uid).where(role_id:rid)  
  }
  def self.create_user_group_role!(uid,gid,rid=6)
    self.create!(user_id:uid,group_id:gid,role_id:rid)
  end
  def self.join_user_group_role(uid,gid,rid=6)
    ugs=self.by_user_group(uid,gid)
    #UserGroup.create!(user_id:uid,group_id:gid,role_id:rid) if ugs.empty?
    self.create_user_group_role!(uid,gid,rid) if ugs.empty?
  end  
end