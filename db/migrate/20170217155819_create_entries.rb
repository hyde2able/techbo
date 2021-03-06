class CreateEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :entries do |t|
      t.string :title
      t.text :body
      t.boolean :is_draft
      t.integer :user_id

      t.timestamps
    end
  end
end
