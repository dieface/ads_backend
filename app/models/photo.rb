# == Schema Information
#
# Table name: photos
#
#  id         :integer          not null, primary key
#  ad_id      :integer
#  image      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Photo < ActiveRecord::Base
  belongs_to :ad, inverse_of: :photos
  validates_presence_of :ad

  mount_uploader :image, ImageUploader
end
