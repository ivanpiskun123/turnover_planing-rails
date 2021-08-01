class Product < ApplicationRecord

  belongs_to :product_group
  has_many :sales

    validates :name, length: {minimum: 2}

end
