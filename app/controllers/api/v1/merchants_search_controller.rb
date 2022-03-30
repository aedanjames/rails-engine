class Api::V1::MerchantsSearchController < ApplicationController
  def find
    if params[:name].present?
    merchant = Merchant.single_merchant(params[:name])
      if merchant.nil? 
        render json: { data: { message: 'Error: Merchant Not Found' } }
      else 
        render json: MerchantSerializer.new(merchant)
      end 
    elsif params[:name].nil? || params[:name].empty?
      render status: 400
    end
  end
end 