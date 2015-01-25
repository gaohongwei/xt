class Task < ActiveRecord::Base
  #attr_accessor :parent_id # only when no has_ancestry
  has_ancestry 
  before_save :set_parent_id  
  has_many :times, :class_name=>'TaskTime'  
  has_many :options, :class_name=>'TaskOption'
  belongs_to :user
  belongs_to :type,:class_name=>'TaskType',:foreign_key=>'type_id' 
  has_many :task_groups
  has_many :groups,through: :task_groups  
  scope :top, lambda {
    #where(ancestry:nil).where(active:true)  
    where(pid:nil).where(active:true).order('order_by asc')       
  }
  scope :by_ids, lambda {|id|
    #where(ancestry:nil).where(active:true)  
    where(id:id)      
  } 
  scope :by_user, lambda {|id|
    #where(ancestry:nil).where(active:true)  
    where(user_id:id)
  }   
  def set_parent_id
    self.parent_id=self.pid   
  end 

  def options
    TaskOption.by_task(self.id)
  end
  def option_users
    TaskOption.by_task(self.id)
  end  
  def root_task_user_groups
    self.root.gorup_ids
  end  
end