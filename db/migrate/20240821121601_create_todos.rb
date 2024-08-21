class CreateTodos < ActiveRecord::Migration[7.1]
  def change
    create_table :todos do |t|
      t.string :content
      t.boolean :completed_flg
      t.boolean :delete_flg

      t.timestamps
    end
  end
end
