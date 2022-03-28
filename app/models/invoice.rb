class Invoice < ApplicationRecord 
  validates :status, presence: true
  
end 