class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :text
      t.integer :user_id
      t.integer :article_id

      t.timestamps
    end
    add_index :comments, [:user_id, :created_at]
    add_index :comments, [:article_id, :created_at]
  end
end
