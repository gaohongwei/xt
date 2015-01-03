class Gallery < ActiveRecord::Base
  has_many :gallery_media
  has_many :media,:through=>:gallery_media 
end