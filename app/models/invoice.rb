class Invoice < ApplicationRecord 
  validates :status, presence: true
  
  belongs_to :customer 
  belongs_to :merchant 

  has_many :invoice_items, dependent: :destroy
  has_many :transactions
  has_many :items, through: :invoice_items

  scope :shipped, -> {where(status:"shipped")}

  def only_item_on_invoice?(item)
    items.count == 1 && items.first.id == item.id
  end

  def self.delete_invoices(invoices, item)
    invoices.each do |invoice|
      if invoice.only_item_on_invoice?(item)
        invoice.destroy
      end 
    end 
  end

  def self.not_shipped_potential_revenue
    Invoice.joins(:invoice_items, :transactions)
    .select("invoices.id, SUM(invoice_items.quantity * invoice_items.unit_price) AS potential_revenue" )
    .where(transactions: {result: 'success' })
    .where.not(invoices: {status: 'shipped' })
    .group('invoices.id')
    .order("potential_revenue DESC")
    # .limit(number)
  end 
end 