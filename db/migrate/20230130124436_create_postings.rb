class CreatePostings < ActiveRecord::Migration[6.1]
  def change
    create_table :postings do |t|
      t.integer :customer_id, null: false
      t.string :body, null: false
      t.boolean :is_active, null: false, default: true

      t.timestamps
    end
  end
end
