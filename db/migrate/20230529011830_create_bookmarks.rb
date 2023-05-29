class CreateBookmarks < ActiveRecord::Migration[7.0]
  def change
    create_table :bookmarks do |t|
      t.integer :user_id,  null: false
      t.integer :board_id, null: false

      t.timestamps
    end
    add_index :bookmarks, [:user_id, :board_id], unique: true
  end
end
