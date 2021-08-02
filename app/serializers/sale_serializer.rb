class SaleSerializer
  include FastJsonapi::ObjectSerializer
  attributes :amount, :total_sum, :payment_method, :trade_form, :month_id, :product_id, :user_id
end
