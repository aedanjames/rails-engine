class Invoice < ApplicationRecord 
  validates :status, presence: true
  
  belongs_to :customer 
  belongs_to :merchant 

  has_many :invoice_items
  has_many :transactions
  has_many :items, through: :invoice_items

  def only_item_on_invoice?(item)
    items.count == 1 && items.first.id == item.id
  end 
end 