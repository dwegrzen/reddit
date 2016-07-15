class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :title
      t.integer :user_id
      t.string :hyperlink
      t.text :summary
      t.integer :votes, default: 0
      t.integer :subreddit_id

      t.timestamps null: false
    end
  end
end
