# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  genre      :string(255)
#  content    :text
#  lat        :float
#  lng        :float
#  address    :string(255)
#  start_date :datetime
#  end_date   :datetime
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#  aasm_state :string(255)      default("available")
#

class Post < ActiveRecord::Base
	belongs_to :author, :class_name => "User", :foreign_key => :user_id

	validate :genre, :presence => true
	validate :content, :presence => true

	def editable_by?(usr)
		user && user == author
	end

end
