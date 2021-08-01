class Sale < ApplicationRecord

 belongs_to :user
 belongs_to :month
 belongs_to :product

 validates :amount, inclusion: { in: 1..99999999999 ,
           message: "(%{value}) can't be less 1 and more 99999999999" }

 validates :total_sum, inclusion: { in: 1..99999999999 ,
           message: "(%{value}) can't be less 1 and more 99999999999" }

 def payment_method_to_s
    self.payment_method? "Наличными" : "Эл. перевод"
 end

 def trade_form_to_s
    self.trade_form? "Опт" : "Розн"
 end

end
