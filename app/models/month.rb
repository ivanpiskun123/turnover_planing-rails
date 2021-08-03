class Month < ApplicationRecord

  # scope :with_juice, -> { where("juice > 0") }
  # Fruit.with_juice.with_round_shape.first(3)

  before_save :date_to_month_start

  has_many :sales

  validates :date, :sales_plan, :price_index, presence: true

  validates :date, uniqueness: true
  validates :sales_plan, inclusion: { in: 1..99999999999 ,
            message: "(%{value}) can't be less 1 and more 99999999999" }

  validates :price_index, numericality: { greater_than_or_equal_to: 0.00001, less_than_or_equal_to: 99999999999}

  def sales_sum
    self.sales.to_a.sum(&:total_sum)
  end

  private

  def date_to_month_start
    self.date = self.date.end_of_month
  end



end
