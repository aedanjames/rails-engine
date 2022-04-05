class Api::V1::Revenue::MerchantsController < ApplicationController 

  def index 
    number = params[:quantity]
    merchants = Merchant.top_merchants_by_revenue(number)
    render json: MerchantNameRevenueSerializer.new(merchants)
  end 

  def show 
    merchant_id = params[:id]
    merchant = Merchant.revenue_for_one_merchant(merchant_id)
    if merchant.nil? || params[:id].empty?
      render status: 404
    else 
      render json: MerchantRevenueSerializer.new(merchant)
    end 
  end 

end 