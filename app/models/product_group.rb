class ProductGroup < ApplicationRecord

  before_save :bla

  has_many :products

  validates :name, length: {minimum: 2}

  def bla
    self.name = "AAAA"
  end


end
