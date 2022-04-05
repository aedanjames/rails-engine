class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def self.single_merchant(name)
    Merchant.find_by("name ilike ?", "%#{name.strip}%")
  end

  def self.multiple_merchants(name)
    Merchant.where("name ilike ?", "%#{name.strip}%")
  end
# calling on Merchant, not a query for one merchant therefore we use a class method
# number comes from the quantity argument param that will be passed into 
  def self.top_merchants_by_revenue(number)
    # joins closest/immediately related table first, then the secondary related tables 
    # another syntax
    # Merchant.joins(invoices: {invoice_items: :transactions})
    Merchant.joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 'success' }, invoices: {status: 'shipped' })
    .select("merchants.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS total_revenue")
    .group('merchants.id')
    # .order(total_revenue: :desc)
    .order('total_revenue DESC')
    # Transaction.where(result: 'success')
    .limit(number)
  end

  def self.top_merchants_by_most_sold(number)
    Merchant.joins(invoices: [:invoice_items, :transactions])
    .select("merchants.*, SUM(invoice_items.quantity) AS count")
    .where(transactions: {result: 'success' }, invoices: {status: 'shipped' })
    .group('merchants.id')
    .order('count DESC')
    .limit(number)
  end

  def self.revenue_for_one_merchant(merchant_id)
    Merchant.joins(invoices: [:invoice_items, :transactions])
    .select("merchants.id, SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue")
    .where(transactions: {result: 'success' }, invoices: {status: 'shipped' })
    .where(merchants: {id: merchant_id})
    .group('merchants.id')
    .first
  end
end