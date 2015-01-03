class ViewAdm < ActiveRecord::Base

  scope :by_controller, lambda {|controller|
    where(:name=>controller)
  }
  scope :by_action, ->(action) {
    where(:action_scope=>action)
  } 
  scope :by_cap_col, ->(cap_col) {
    where(:cap_col=>cap_col)
  }   
end