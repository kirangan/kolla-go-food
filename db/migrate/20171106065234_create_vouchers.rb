class CreateVouchers < ActiveRecord::Migration[5.1]
  def change
    create_table :vouchers do |t|
      t.string :code_name
      t.datetime :valid_from
      t.datetime :valid_through
      t.decimal :amount
      t.integer :unit

      t.timestamps
    end
  end
end
