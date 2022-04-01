require 'rails_helper'

RSpec.describe Invoice, type: :model do 
  describe 'relationships' do 
    it { should belong_to :customer }
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many :transactions }
    it { should have_many(:items).through(:invoice_items) }
  end 
  
  describe 'validations' do 
    it { should validate_presence_of :status }
  end 

  describe 'instance methods' do 
    describe '.only_item_on_invoice' do 
      it 'returns a boolean whether an item is the only item on an invoice' do 
        customer = create(:customer)
        merchant = create(:merchant)
        item = create(:item, merchant_id: merchant.id)
        invoice = Invoice.create!(customer_id: customer.id, merchant_id: merchant.id, status: "shipped")
        joins = InvoiceItem.create!(invoice_id: invoice.id, item_id: item.id, quantity: 1, unit_price: 10)
        expect(invoice.only_item_on_invoice?(item)).to eq(true)
        item_2 = create(:item, merchant_id: merchant.id)
        joins = InvoiceItem.create!(invoice_id: invoice.id, item_id: item_2.id, quantity: 1, unit_price: 10)
        expect(invoice.only_item_on_invoice?(item)).to eq(false)
      end 
    end 
  end

  describe 'class methods' do 
    describe '#delete_invoices' do 
      it 'iterates through an array of invoices and deletes them if they only have one item (which is also being deleted)' do
        customer = create(:customer)
        merchant = create(:merchant)
        item = create(:item, merchant_id: merchant.id)
        invoice = Invoice.create!(customer_id: customer.id, merchant_id: merchant.id, status: "shipped")
        joins = InvoiceItem.create!(invoice_id: invoice.id, item_id: item.id, quantity: 1, unit_price: 10)
        expect(Invoice.all).to eq([invoice])
        Invoice.delete_invoices([invoice], item)
        expect(Invoice.all).to eq([])
      end 
    end 
  end 
end 