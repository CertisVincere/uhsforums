class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :name
      t.text :content
      t.string :filename
      t.string :content_type
      t.binary :file_contents
      
      t.timestamps null: false
    end
  end
end
