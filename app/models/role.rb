class Role < ActiveRecord::Base
  scope :by_name, lambda {|name|
    where(name:name)
  }
end