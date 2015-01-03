class Event < ActiveRecord::Base
  before_destroy :stop_delete  
  def stop_delete
   if self.id < 2
     raise ActiveRecord::Rollback
   end
  end 
end