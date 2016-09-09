class CreateReplies < ActiveRecord::Migration[5.0]
  def change
    create_table :replies do |t|
      t.belongs_to  :user
      t.belongs_to  :topic
      t.string      :title
      t.text        :body
      t.string      :liked_user_ids
      t.integer     :likes_count,        default: 0
      t.timestamps
    end
  end
end
