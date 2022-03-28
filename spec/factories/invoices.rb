FactoryBot.define do
  factory :invoice do
    customer 
    merchant
    status { ["shipped", "packaged"].sample }
  end
end