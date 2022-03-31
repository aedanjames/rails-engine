class Api::V1::ItemsSearchController < ApplicationController
  def find_all 
    if params[:name].present?
    items = Item.multiple_items(params[:name]) 
      if items 
        render json: ItemSerializer.new(items)
      elsif items.nil?
        render json: { data: { message: 'Error: Item Not Found' } }
      end 
    elsif params[:name].nil? || params[:name].empty?
      render status: 400
    end 
  end

  def find 
    if params[:name].present?
    items = Item.one_item(params[:name]) 
      if items 
        render json: ItemSerializer.new(items)
      elsif items.nil?
        render json: { data: { message: 'Error: Item Not Found' } }
      end 
    elsif params[:name].nil? || params[:name].empty?
      render status: 400
    end 
  end
end 