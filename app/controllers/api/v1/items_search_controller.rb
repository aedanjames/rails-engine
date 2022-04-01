class Api::V1::ItemsSearchController < ApplicationController
  def find 
    if params[:name].present?
      item = Item.one_item(params[:name]) 
      if item 
        render json: ItemSerializer.new(item)
      elsif item.nil?
        render json: { data: { message: 'Error: Item Not Found' } }
      end 
    elsif params[:min_price].present? 
      item = Item.min_price_item(params[:min_price])
      if item 
        render json: ItemSerializer.new(item)
      elsif item.nil? 
        render json: { data: { message: 'Error: Item Not Found' } }
      end 
    elsif params[:max_price].present?
      item = Item.max_price_item(params[:max_price])
      if item
      render json: ItemSerializer.new(item)
      elsif item.nil?
        render json: { data: { message: 'Error: Item Not Found' } }
      end 
    else 
      render status: 400
    end 
  end

  def find_all 
    if params[:name].present?
    items = Item.multiple_items(params[:name])
      if items 
        render json: ItemSerializer.new(items)
      end 
    elsif params[:name].nil? || params[:name].empty?
      render status: 400
    end 
  end
end 