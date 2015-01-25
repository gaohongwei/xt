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
  def self.update(uid,gid,role_name='read')
    role=Role.find_by_name(role_name)
    return if role.nil?
    rid=role.id 
    #UserGroup.create!(user_id:uid,group_id:gid,role_id:rid) if ugs.empty?
    if uid.is_a?(Integer)
      uids=[uid]
    else
      uids=uid
    end
    uids.each do |uid|
      ugs=self.by_user_group(uid,gid)
      if ugs.any?
        ugs[0].role_id=rid
        ugs[0].save!
      else
        self.create_user_group_role!(uid,gid,rid)       
      end
    end
  end     
end