class CreateBuyers < ActiveRecord::Migration[5.1]
  def change
    create_table :buyers do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.text :address

      t.timestamps
    end
  end
end
