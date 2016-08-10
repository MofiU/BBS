class CreateNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :notes do |t|
      t.belongs_to :user
      t.string :title
      t.text :body
      t.boolean :public, null: false, default: false
      t.integer :word_count, default: 0
      t.datetime :deleted_at, null: true
      t.timestamps
    end
  end
end
