class Group < ActiveRecord::Base
  has_many :user_groups
  has_many :task_groups  
  has_many :users,through: :user_groups
  has_many :tasks,through: :task_groups  
  before_save :set_default
  #before_destroy :stop_delete
  scope :by_id, lambda {|id| where(id:id)} 
  scope :by_user,  lambda {|id|where(user_id:id)}    
  attr_accessor :my_role   
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