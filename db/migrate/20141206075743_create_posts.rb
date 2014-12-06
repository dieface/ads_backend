class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :type
      t.text :content
      t.float :lat
      t.float :lng
      t.string :address
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
