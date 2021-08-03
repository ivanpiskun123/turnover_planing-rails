class Month < ApplicationRecord

  # scope :with_juice, -> { where("juice > 0") }
  # Fruit.with_juice.with_round_shape.first(3)

  scope :previous_month, ->(month) { where(date: (month.date-1.month).end_of_month  ) }

  before_save :date_to_month_start
  
  has_many :sales, depent: :destroy

  validates :date, :sales_plan, :price_index, presence: true

  validates :date, uniqueness: true
  validates :sales_plan, inclusion: { in: 1..99999999999 ,
            message: "(%{value}) can't be less 1 and more 99999999999" }

  validates :price_index, numericality: { greater_than_or_equal_to: 0.00001, less_than_or_equal_to: 99999999999}


  def sales_sum
    self.sales.to_a.sum(&:total_sum)
  end

  def plan_compl_percent
     (self.sales_sum.to_f / self.sales_plan).round(4)
  end

  def sales_sum_indexed
    (self.sales_sum.to_f / self.price_index).round(2)
  end

  def growth_rate_percent
    if self.date.month == 1
      100.0
    else
      (self.sales_sum_indexed / Month.previous_month(self).first.sales_sum_indexed ).round(2)
    end
  end

  def rate_of_increase_percent
    if self.date.month == 1
      0
    else
      self.growth_rate_percent - Month.previous_month(self).first.growth_rate_percent
    end
  end



  private

  def date_to_month_start
    self.date = self.date.end_of_month
  end



end
