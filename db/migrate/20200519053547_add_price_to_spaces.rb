class AddPriceToSpaces < ActiveRecord::Migration[6.0]
  def change
    add_column :spaces, :price, :integer
  end
end
