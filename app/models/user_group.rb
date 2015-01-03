class UserGroup < ActiveRecord::Base
  belongs_to :group
  belongs_to :user  

  scope :by_user,lambda {|id|
    where(user_id:id)  
  }
  scope :by_group,lambda {|id|
    where(group_id:id)  
  }  
  scope :by_role,lambda {|id|
    where(role_id:id)  
  }  
  scope :by_user_role,lambda {|uid,rid|
    where(user_id:uid).where(role_id:rid)  
  }
end