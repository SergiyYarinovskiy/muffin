require 'spec_helper'

describe Hotel do
  it { should have_many(:comments) }
  it { should have_one(:address) }
  it { should belong_to(:user) }
  it { should accept_nested_attributes_for(:address) }

  it { should have_attached_file(:hotel_image) }
  it { should validate_attachment_content_type(:hotel_image).
                  allowing('image/png', 'image/gif', 'image/jpeg', 'image/jpg') }
  it { should validate_attachment_size(:hotel_image).
                    less_than(10.megabytes) }

  it 'checks if model returns top 5 hotels' do
    h2 = Hotel.create(title: 'h2', rating: 5.0)
    h3 = Hotel.create(title: 'h3', rating: 4.0)
    h1 = Hotel.create(title: 'h1', rating: 3.0)
    h4 = Hotel.create(title: 'h4', rating: 2.0)
    h5 = Hotel.create(title: 'h5', rating: 1.0)
    Hotel.create(title: 'h6', rating: 0.0)

    expect(Hotel.sort_hotels).to eq [{title: h2.title, average_rating: h2.rating},
                                        {title: h3.title, average_rating: h3.rating},
                                        {title: h1.title, average_rating: h1.rating},
                                        {title: h4.title, average_rating: h4.rating},
                                        {title: h5.title, average_rating: h5.rating}]
  end
end