class Month < ApplicationRecord



  has_many :sales

  validates :date, :sales_plan, :price_index, presence: true

  validates :date, uniqueness: true
  validates :sales_plan, inclusion: { in: 1..99999999999 ,
            message: "%{value} can't be less 1 and more 99999999999" }

  validates :price_index, numericality: { greater_than_or_equal_to: 0.00001, less_than_or_equal_to: 99999999999}

  private


end
