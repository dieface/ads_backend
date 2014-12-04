class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.string :scale
      t.datetime :start_date
      t.datetime :end_date
      t.float :lat
      t.float :lng
      t.string :url
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
