class Shoe < ApplicationRecord
    validates :name, :price, :image, :description, presence: true
    validates :description, length:  {minimum: 10}
end
