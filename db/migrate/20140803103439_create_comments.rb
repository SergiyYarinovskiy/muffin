class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :hotel
      t.string :user_name
      t.text :body
      t.integer :rating

      t.timestamps
    end
  end
end
