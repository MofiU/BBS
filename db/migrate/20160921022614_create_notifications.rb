class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.belongs_to :user
      t.string :type
      t.string :title
      t.string :body
      t.integer :sender_id, :default => 10000
      t.boolean :read, :default => false
      t.timestamps
    end
  end
end
