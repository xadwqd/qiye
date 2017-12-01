class Courier < ApplicationRecord
  has_and_belongs_to_many :stations

  def to_s
    self.name
  end
end
