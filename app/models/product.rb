class Product < ApplicationRecord
  belongs_to :category, required: true
end
