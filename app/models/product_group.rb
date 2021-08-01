class ProductGroup < ApplicationRecord



  has_many :products

  validates :name, length: {minimum: 2}
  validates :name, uniqueness: true


end
