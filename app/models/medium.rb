#rails generate paperclip media item
#http://railscasts.com/episodes/134-paperclip?view=asciicast
class Medium < ActiveRecord::Base
  has_many :gallery_media
  has_many :galleries,:through=>:gallery_media 
  has_attached_file :item, :styles => { 
    :large => "691x419>",   
    :medium => "217x131>", 
    :small => "148x90>",                       
    :thumb => "64x39>", 
    :icon => "22x22>"},    
    #:default_url => "/images/:style/missing.png",
    :url => "/assets/products/:id/:style/:basename.:extension",
    :path => ":rails_root/public/assets/products/:id/:style/:basename.:extension"  
  #validates_attachment_content_type :item, :content_type => /\Aimage\/.*\Z/
  validates_attachment_content_type :item, :content_type => 
  [/\Aimage\/.*\Z/,/\Avideo\/.*\Z/,'application/pdf','image/jpg', 'image/png',"video/mp4", "image/jpg", "image/jpeg", "image/png", "image/gif"]
=begin  
  validates_attachment_content_type :item,
    :content_type => ['video/mp4'],
    :message => "Sorry, right now we only support MP4 video",
    :if => :is_type_of_video?
  validates_attachment_content_type :item,
     :content_type => ['image/png', 'image/jpeg', 'image/jpg', 'image/gif'],
     :message => "Different error message",
     :if => :is_type_of_image?
  protected
  def is_type_of_video?
    item.content_type =~ %r(video)
  end

  def is_type_of_image?
    item.content_type =~ %r(image)
  end   
=end  
end