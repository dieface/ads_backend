class ChangeColumnTypeToGenreInPosts < ActiveRecord::Migration
  def change
  	rename_column :posts, :type, :genre
  end
end
