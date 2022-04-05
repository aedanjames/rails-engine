class InvoiceItem < ApplicationRecord 
  validates :quantity, presence: true
  validates :unit_price, presence: true
  
  belongs_to :item 
  belongs_to :invoice
  has_many :transactions, through: :invoice


  # def self.items_with_most_revenue(number)
  #   InvoiceItem.joins(:items, invoices: [:transactions])
  #   .select("items.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue")
  #   .where(transactions: {result: 'success' }, invoices: {status: 'shipped' })
  #   .group("items.id")
  #   .order("revenue DESC")
  #   .limit(number)
  # end
end 