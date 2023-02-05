class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :posting_id, null: false
      t.string :address
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
