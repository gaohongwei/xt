class Task < ActiveRecord::Base
  #attr_accessor :parent_id # only when no has_ancestry
  has_ancestry 
  before_save :set_parent_id  
  has_many :times, :class_name=>'TaskTime'  
  has_many :options, :class_name=>'TaskOption'
  belongs_to :user
  belongs_to :type,:class_name=>'TaskType',:foreign_key=>'type_id' 
  scope :top, lambda {
    #where(ancestry:nil).where(active:true)  
    where(pid:nil).where(active:true).order('order_by asc')       
  }
  def set_parent_id
    self.parent_id=self.pid   
  end 
  scope :by_user, lambda {|id|
    #where(ancestry:nil).where(active:true)  
    where(user_id:id)
  }
  def options
    TaskOption.by_task(self.id)
  end
  def option_users
    TaskOption.by_task(self.id)
  end    
end