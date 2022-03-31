class Api::V1::MerchantsSearchController < ApplicationController
  def find
    if params[:name].present?
    merchant = Merchant.single_merchant(params[:name])
      if merchant
        render json: MerchantSerializer.new(merchant)
      elsif merchant.nil?
        render json: { data: { message: 'Error: Merchant Not Found' } }
      end 
    elsif params[:name].nil? || params[:name].empty?
      render status: 400
    end
  end

  def find_all 
    if params[:name].present?
      merchants = Merchant.multiple_merchants(params[:name])
      if merchants
        render json: MerchantSerializer.new(merchants)
      end 
    elsif params[:name].nil? || params[:name].empty?
      render status: 400
    end
  end 
end 