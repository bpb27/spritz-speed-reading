class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.integer :chapter
      t.text :content

      t.timestamps
    end
  end
end
