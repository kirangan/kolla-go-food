class CreateFoodsTags < ActiveRecord::Migration[5.1]
  def change
    create_table :foods_tags do |t|
      t.belongs_to :food, foreign_key: true
      t.belongs_to :tag, foreign_key: true
    end
  end
end
