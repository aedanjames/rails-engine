class Api::V1::MerchantsController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end

  def most_items
    number = params[:quantity]
    merchants = Merchant.top_merchants_by_most_sold(number)
    render json: MerchantNameMostItemsSerializer.new(merchants)
  end

end 