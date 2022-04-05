class MerchantRevenueSerializer
  include FastJsonapi::ObjectSerializer
  
  attributes :revenue do |object|
    object.revenue
  end
end