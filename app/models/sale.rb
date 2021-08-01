class Sale < ApplicationRecord



 belongs_to :user
 belongs_to :month
 belongs_to :product

 validates :amount, inclusion: { in: 1..99999999999 ,
           message: "%{value} can't be less 1 and more 99999999999" }

 validates :total_sum, inclusion: { in: 1..99999999999 ,
           message: "%{value} can't be less 1 and more 99999999999" }

  private

  def payment_method_to_string

  end

  def trade_form_to_string

  end

end
