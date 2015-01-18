class TaskGroup < ActiveRecord::Base
  belongs_to :task
  belongs_to :group
end