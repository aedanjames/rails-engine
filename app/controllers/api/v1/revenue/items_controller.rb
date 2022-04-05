class Api::V1::Revenue::ItemsController < ApplicationController 

  def index 
    if params[:quantity].nil?
      number = "10"
      # items = InvoiceItem.items_with_most_revenue(number)
      items = Item.items_with_most_revenue(number)
      render json: ItemRevenueSerializer.new(items)
    elsif params[:quantity].to_i <= 0 || params[:quantity].empty?
      render status: 400
    elsif params[:quantity].nil? == false
      number = params[:quantity]
      # items = InvoiceItem.items_with_most_revenue(number)
      items = Item.items_with_most_revenue(number)
      render json: ItemRevenueSerializer.new(items)
    end 
  end 

end
