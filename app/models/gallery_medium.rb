class GalleryMedium < ActiveRecord::Base
  belongs_to :gallery
  belongs_to :medium 
end