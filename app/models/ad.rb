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

  # before_save :parse_date

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

  def default_photo
    photos.first
  end

	def editable_by?(user)
		user && user == owner
	end

  # def parse_date
  #   unless start_date_string.blank?
  #     self.start_date = DateTime.parse(start_date_string)
  #   end

  #   unless end_date_string.blank?
  #     self.end_date = DateTime.parse(end_date_string)
  #   end
  # end	
end
