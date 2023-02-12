class AddDetailsToPostings < ActiveRecord::Migration[6.1]
  def change
    add_column :postings, :lat, :float
    add_column :postings, :lng, :float
  end
end
