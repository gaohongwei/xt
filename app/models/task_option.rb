class TaskOption < ActiveRecord::Base
  #TaskOption.joins(:task)
  #attr_accessor :users_count  
  belongs_to :task
  belongs_to :user  
  has_many :users, :class_name=>'OptionUser',:foreign_key=>'option_id'

  @@fields="task_options.id,task_options.name,task_options.task_id,task_options.user_id"
  scope :by_task,lambda {|id|
    select(@@fields).
    where(task_id:id)  
  } 
  scope :by_user,lambda {|id|
    select(@@fields).    
    where(user_id:id)  
  }  
  def self.user_vote
    select("task_options.id, task_options.name,count(option_users.id) AS vote").
    joins("LEFT JOIN option_users ON option_users.option_id = task_options.id").
    group("task_options.id").
    order("vote desc")
  end 
  scope :by_task_with_user,lambda {
    select("task_options.id,task_options.name,task_options.task_id,task_options.user_id,users.wname").  
    includes(:user).
    joins(:user)
  }
  scope :with_user,lambda { 
    select("task_options.id,task_options.name,task_options.task_id,task_options.user_id,users.wname").     
    includes(:user) 
  }
end