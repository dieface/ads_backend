# == Schema Information
#
# Table name: ads
#
#  id          :integer          not null, primary key
#  scale       :string(255)
#  start_date  :datetime
#  end_date    :datetime
#  lat         :float
#  lng         :float
#  url         :string(255)
#  title       :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#  aasm_state  :string(255)      default("unavailable")
#

class Ad < ActiveRecord::Base
	belongs_to :owner, :class_name => "User", :foreign_key => :user_id

  has_many :photos, inverse_of: :ad
  accepts_nested_attributes_for :photos

  validates :scale, :presence => true
	validates :start_date, :presence => true
	validates :end_date, :presence => true
	validates :lat, :presence => true
	validates :lng, :presence => true
	validates :url, :presence => true
	validates :title, :presence => true
	validates :description, :presence => true
	validates :photos, :presence => true

  # before_save :parse_date
	# after_save 	:write_json

  def default_photo
    photos.first
  end

	def editable_by?(user)
		user && user == owner
	end


	# def write_json
	#   ads_json = []
	#   Ad.all.each do |ad|
	#     ad_json = {
	# 			"id" => ad.id,
	# 			"scale" => ad.scale,
	# 			"start_date" => ad.start_date,
	# 			"end_date" => ad.end_date,
	# 			"lat" => ad.lat,
	# 			"lng" => ad.lng,
	# 			"url" => ad.url,
	# 			"title" => ad.title,
	# 			"description" => ad.description,
	# 			"created_at" => ad.created_at,
	# 			"updated_at" => ad.updated_at,
	# 			"user_id" => ad.user_id,
	# 			"aasm_state" => ad.aasm_state,
	# 			"default_photo_url" => full_image_path(ad.default_photo.image.path)
	#     } 
	#     ads_json << ad_json
	#   end
	#   File.open("public/ads.json","wb") do |f|
	#     f.write(ads_json.to_json)
	#   end 
	# end

	# def image_abs_url(image_url)
	#   URI.join(root_url, image_url)
	# end

	# def full_image_path(img_path)
	#     request.protocol + request.host_with_port + image_path(img_path)
	# end	
  # def parse_date
  #   unless start_date_string.blank?
  #     self.start_date = DateTime.parse(start_date_string)
  #   end

  #   unless end_date_string.blank?
  #     self.end_date = DateTime.parse(end_date_string)
  #   end
  # end	
end
