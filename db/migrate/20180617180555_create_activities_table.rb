class CreateActivitiesTable < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name
      t.string :activity_date
      t.integer :activity_time
      t.float :distance
      t.float :pace_avg
      t.float :speed_avg
      t.float :hr_avg
      t.integer :user_id
      t.integer :category_id
    end
  end
end
