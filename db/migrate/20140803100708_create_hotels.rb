class CreateHotels < ActiveRecord::Migration
  def change
    create_table :hotels do |t|
      t.belongs_to :user
      t.string :title
      t.integer :rating
      t.boolean :breakfast_in
      t.text :room_description
      t.float :price

      t.timestamps
    end
  end
end
