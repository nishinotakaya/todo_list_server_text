class AddSortToTodos < ActiveRecord::Migration[7.1]
  def change
    add_column :todos, :sort, :integer, null: false, default: 0
  end
end
