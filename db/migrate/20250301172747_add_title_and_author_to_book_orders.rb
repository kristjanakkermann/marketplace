class AddTitleAndAuthorToBookOrders < ActiveRecord::Migration[8.0]
  def change
    add_column :book_orders, :title, :string
    add_column :book_orders, :author, :string
  end
end
