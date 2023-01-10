class Chef < ApplicationRecord
  validates_presence_of :name
  has_many :dishes
  has_many :ingredients, through: :dishes

  def distinct_ingredients
    self.ingredients
  end
end