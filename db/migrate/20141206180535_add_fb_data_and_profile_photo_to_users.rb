class AddFbDataAndProfilePhotoToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :profile_photo, :string
  	add_column :users, :fb_data, :text
  end
end
