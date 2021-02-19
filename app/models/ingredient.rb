class Ingredient < ApplicationRecord
  has_many :doses
  has_one_attached :photo

  validates :name, presence: true, uniqueness: true, allow_blank: false
  
  
end
