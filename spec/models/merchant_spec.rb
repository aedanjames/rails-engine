require 'rails_helper'

RSpec.describe Merchant, type: :model do 
  describe 'relationships' do 
    it { should have_many :items }
    it { should have_many :invoices }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end 
  
  describe 'validations' do 
    it { should validate_presence_of :name }
  end 

  describe 'class methods' do 
    describe '#single_merchant' do 
      it 'returns one merchant whos name matches an argument, case insensitive' do 
        merchant_1 = Merchant.create!(name: "The Stranger")
        merchant_2 = Merchant.create!(name: "The Strangest")
        expect(Merchant.single_merchant("STranGe ")).to eq(merchant_1)
        expect(Merchant.single_merchant("STranGe ")).to_not eq(merchant_2)
      end 
    end 

    describe '#multiple_merchants' do 
      it 'returns all merchant whos name matches an argument, case insensitive' do 
        merchant_1 = Merchant.create!(name: "The Stranger")
        merchant_2 = Merchant.create!(name: "The Strangest")
        merchant_3 = Merchant.create!(name: "Fred")
        expect(Merchant.multiple_merchants("STranGe ")).to eq([merchant_1, merchant_2])
        expect(Merchant.multiple_merchants("STranGe ")).to_not eq(merchant_3)
      end 
    end 
  end 
end 