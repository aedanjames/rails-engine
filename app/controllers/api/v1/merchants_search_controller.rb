class Api::V1::MerchantsSearchController < ApplicationController
  def find
    merchant = Merchant.single_merchant(params[:name])
    render json: MerchantSerializer.new(merchant)
  end
end 