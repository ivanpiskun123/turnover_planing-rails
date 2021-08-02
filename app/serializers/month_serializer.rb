class MonthSerializer
  include FastJsonapi::ObjectSerializer
  attributes :date, :sales_plan, :price_index

  has_many :sales
  
end
