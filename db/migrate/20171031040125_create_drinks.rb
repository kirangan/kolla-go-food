class CreateDrinks < ActiveRecord::Migration[5.1]
  def change
    create_table :drinks do |t|
      t.string :name
      t.text :description
      t.string :image_url
      t.decimal :price
    end
  end
end
