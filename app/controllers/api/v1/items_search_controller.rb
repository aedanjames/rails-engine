class Api::V1::ItemsSearchController < ApplicationController
  def find_all 
    items = Item.multiple_items(params[:name])
    if items 
      render json: ItemSerializer.new(items)
    elsif items.nil?
      render json: { data: { message: 'Error: Item Not Found' } }
    end 
  end
end 