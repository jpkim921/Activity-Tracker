class CreateCategoriesTable < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :activity_type
    end
  end
end
