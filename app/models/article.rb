class Article < ActiveRecord::Base
  acts_as_taggable_on :tags  
  #belongs_to :type
  before_save :set_default
  def set_default
    #self.type_id=1 if self.type_id.nil?
    self.permalink=self.title.strip.tr(' ','-') if self.permalink.nil? || self.permalink.empty?
  end  
end  