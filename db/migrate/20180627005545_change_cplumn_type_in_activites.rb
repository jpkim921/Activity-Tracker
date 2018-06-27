class ChangeCplumnTypeInActivites < ActiveRecord::Migration
  def change
      change_column :activities, :hr_avg, :integer
      change_column :activities, :activity_time, :string
      change_column :activities, :pace_avg, :string
  end
end
