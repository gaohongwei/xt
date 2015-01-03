class OptionUser < ActiveRecord::Base
  #OptionUser.joins(:option)
  #OptionUser.joins(:option=>(:task))  
  belongs_to :option, :class_name=>'TaskOption',:foreign_key=>'option_id'

  attr_accessor :opts
  scope :by_task,lambda {|id|
    joins(:option=>(:task)).merge(Task.where(id:id))
  } # id can be a array, [1,2]
  scope :by_user,lambda {|id|
    where(user_id:id)  
  } 
  scope :by_option,lambda {|id|
    where(option_id:id)  
  }
  def self.user_vote
    select("option_users.option_id, count(option_users.user_id) AS vote").
    group("option_users.option_id").
    order("vote desc")
  end 

  def self.get_options(task_id,user_id) 
  # task_ids can be array
    return [] unless task_id  
    task=Task.find(task_id)  
    return [] unless task

    if task_id.is_a?(Array)
      task_ids=task_id  
    else
      if task.root?
        root=task
      else
        root=task.root
      end   
      task_ids=root.descendant_ids  
      task_ids<<task_id unless task_ids.include?(task_id)
    end
    if user_id    
      opts_old=self.by_task(task_ids).by_user(user_id)
    else
      opts_old=self.by_task(task_ids)      
    end
    opts_old.map{|x|x.option_id}
  end

  def self.set_options(new_option_ids,user_id)
    return if new_option_ids.empty?  

    ids_new=new_option_ids
    option1=TaskOption.find(ids_new[0])    
    root=option1.task.root
    root_id=root.id
    tids=root.descendant_ids
    tids<<root_id unless tids.include?(root_id) 
       
    opts_old=OptionUser.by_task(tids).by_user(user_id)
    ids_old=opts_old.map{|x|x.option_id} 
    ids_add=ids_new-ids_old
    ids_del=ids_old-ids_new
    ids_add.each do |opt|
      OptionUser.create!(option_id:opt,user_id:user_id)
    end  
   
    ids_del.each do |opt|
      OptionUser.destroy_all(["option_id=? and user_id=?",opt,user_id])
    end 
    puts "ids_del=#{ids_del}"     
    puts "ids_add =#{ids_add}"  
  end
end