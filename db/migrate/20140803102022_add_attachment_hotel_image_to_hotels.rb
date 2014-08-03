class AddAttachmentHotelImageToHotels < ActiveRecord::Migration
  def self.up
    change_table :hotels do |t|
      t.attachment :hotel_image
    end
  end

  def self.down
    remove_attachment :hotels, :hotel_image
  end
end
