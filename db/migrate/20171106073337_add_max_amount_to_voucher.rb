class AddMaxAmountToVoucher < ActiveRecord::Migration[5.1]
  def change
    add_column :vouchers, :max_amount, :decimal
  end
end
