require 'rails_helper'

RSpec.describe Item, type: :model do 
  describe 'relationships' do 
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
  end 
  
  describe 'validations' do 
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
  end 

  describe 'class methods' do 
    describe '#multiple_items' do 
      it 'retrieves all items that match a case-insensitive search' do 
        merchant = Merchant.create!(name: "The Duke")
        item_1 = Item.create!(name: "Hat", description: "Trusty Orange Hat", unit_price: 10, merchant_id: merchant.id)
        item_2 = Item.create!(name: "Cat", description: "Mantis", unit_price: 10, merchant_id: merchant.id)
        item_3 = Item.create!(name: "Jacket", description: "Cozy", unit_price: 10, merchant_id: merchant.id)
        expect(Item.multiple_items("at")).to eq([item_1, item_2])
        expect(Item.multiple_items("At ")).to eq([item_1, item_2])
        expect(Item.multiple_items(" At ")).to eq([item_1, item_2])
        expect(Item.multiple_items(" At ").include?(item_3)).to eq(false)
      end 
    end 
  end
end 