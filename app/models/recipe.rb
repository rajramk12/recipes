class Recipe < ApplicationRecord
  validates :name , presence: true
  validates :description, presence: true, length: {minimum: 10, maximum: 500}

  belongs_to :chef
end 