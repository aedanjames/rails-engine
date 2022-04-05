class UnshippedRevenueSerializer
  include FastJsonapi::ObjectSerializer
  
  attributes :potential_revenue do |object|
    object.potential_revenue
  end
end