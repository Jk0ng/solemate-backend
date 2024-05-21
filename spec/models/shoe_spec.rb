require 'rails_helper'

RSpec.describe Shoe, type: :model do
  it "should validate name" do
    shoe = Shoe.create(
      price: 200,
      description:
       "This shoe is the first signature shoe of the famous basketball player Michael Jordan and the first model of the Air Jordan series.",
      image:
        "https://live.staticflickr.com/8498/8341734396_76195b59bd_b.jpg")
    # expect an error to appear, so "to not be empty" is expected to be true #
    expect(shoe.errors[:name]).to_not be_empty 
  end
end

RSpec.describe Shoe, type: :model do
  it "should validate a price" do
    shoe = Shoe.create(
      name: "Nike Jordan 1",
      description:
       "This shoe is the first signature shoe of the famous basketball player Michael Jordan and the first model of the Air Jordan series.",
      image:
        "https://live.staticflickr.com/8498/8341734396_76195b59bd_b.jpg"
    )
    expect(shoe.errors[:price]).to_not be_empty
  end
end

RSpec.describe Shoe, type: :model do
  it "should validate an image" do
    shoe = Shoe.create(
      name: "Nike Jordan 1",
      price: 200,
      description:
       "This shoe is the first signature shoe of the famous basketball player Michael Jordan and the first model of the Air Jordan series." 
    )
    expect(shoe.errors[:image]).to_not be_empty
  end
end

RSpec.describe Shoe, type: :model do
  it "should validate that description must be more than 10 characters" do
    shoe = Shoe.create(
      name: "Nike Jordan 1",
      price: 200,
      description: "<10ch",
      image:
        "https://live.staticflickr.com/8498/8341734396_76195b59bd_b.jpg"
    )
    expect(shoe.errors[:description]).to_not be_empty
  end
end
