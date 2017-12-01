class Product < ApplicationRecord
  belongs_to :category, required: true

  has_one :price, dependent: :destroy
end
