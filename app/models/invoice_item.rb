class InvoiceItem < ApplicationRecord 
  validates :quantity, presence: true
  validates :unit_price, presence: true
  
  belongs_to :item 
  belongs_to :invoice
  has_many :transactions, through: :invoice

end 