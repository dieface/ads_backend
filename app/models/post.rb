class Post < ActiveRecord::Base
	belongs_to :author, :class_name => "User", :foreign_key => :user_id

	validate :type, :presence => true
	validate :content, :presence => true

	def editable_by?(usr)
		user && user == author
	end

end
