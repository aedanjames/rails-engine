class MerchantNameMostItemsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name

  attributes :count do |object|
    # "#{object.total_revenue}"
    object.count
  end
end