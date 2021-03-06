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
end 