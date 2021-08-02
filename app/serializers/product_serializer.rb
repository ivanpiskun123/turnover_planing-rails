class ProductSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :product_group_id
end
