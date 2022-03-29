class Api::V1::MerchantsSearchController < ApplicationController
  def find
    merchant = Merchant.single_merchant(params[:name])
    if merchant
    render json: MerchantSerializer.new(merchant)
    elsif merchant.nil?
      render json: { data: { message: 'Error: Merchant Not Found' } }
    end
  end
end 