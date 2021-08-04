module Types
  class AveragePriceInMonthType < Types::BaseObject

    field :id, ID, null: false
    field :month_number, Int, null: false
    field :average_sales_price, Float, null: false


  end
end
