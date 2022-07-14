class Recipe < ApplicationRecord
  validates :name , presence: true
  validates :description, presence: true, length: {minimum: 10, maximum: 500}

  belongs_to :chef
  validates :chef_id, presence: true
  # to get recent recipes
  default_scope -> {order(updated_at: :desc)}
end
