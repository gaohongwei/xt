class Group < ActiveRecord::Base
  has_many :user_groups
  has_many :users,:through=>:user_groups
  before_save :set_default
  before_destroy :stop_delete
  def stop_delete
   if self.id < 11
     raise ActiveRecord::Rollback
   end
  end
  def set_default
    self.active=true if self.active.nil?
    self.name||=self.vname
  end 
  def vname
    self.name||self.description
  end   
  def user_list
    self.users.map{|x|x.vname}.join(',')
  end  
end