class AddCategoryIdToFood < ActiveRecord::Migration[5.1]
  def change
    add_column :foods, :category_id, :integer
  end
end
