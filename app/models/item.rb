class Item < ApplicationRecord 
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true

  belongs_to :merchant 
  
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  def self.multiple_items(name)
    Item.where("name ilike ?", "%#{name.strip}%")
  end

  def self.one_item(name)
    Item.find_by("name ilike ?", "%#{name.strip}%")
  end 

  def self.min_price_item(price)
    Item.find_by("unit_price >= ?", price)
  end 

  def self.max_price_item(price)
    Item.find_by("unit_price <= ?", price)
  end 
end 