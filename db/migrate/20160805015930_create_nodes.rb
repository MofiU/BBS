class CreateNodes < ActiveRecord::Migration[5.0]
  def change
    create_table :nodes do |t|
      t.string   :category,        null: false
      t.string   :name,            null: false
      t.timestamps
    end
  end
end
