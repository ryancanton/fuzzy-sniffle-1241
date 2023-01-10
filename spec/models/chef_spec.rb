require 'rails_helper'

RSpec.describe Chef, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
  end
  describe "relationships" do
    it {should have_many :dishes}
    it {should have_many(:ingredients).through(:dishes)}
  end

  describe "#distinct_ingredients" do
    it 'returns a list of all distinct ingredients a chef uses' do
      chef = Chef.create!(name: 'Chef')
      chili = chef.dishes.create!(name: 'Chefs Chili', description: 'The famous schoolhouse chili')
      taco_meat = chef.dishes.create!(name: 'Chefs Taco Meat', description: 'The famous schoolhouse taco meat')
      beef = Ingredient.create!(name: 'Ground Beef', calories: 123)
      beans = Ingredient.create!(name: 'Baked Beans', calories: 74)
      cheese = Ingredient.create!(name: 'Mixed Cheese', calories: 104)
      DishIngredient.create!(ingredient_id: beef.id, dish_id: chili.id)
      DishIngredient.create!(ingredient_id: beans.id, dish_id: chili.id)
      DishIngredient.create!(ingredient_id: cheese.id, dish_id: chili.id)
      DishIngredient.create!(ingredient_id: beef.id, dish_id: taco_meat.id)
      DishIngredient.create!(ingredient_id: cheese.id, dish_id: taco_meat.id)

      expect(chef.distinct_ingredients).to eq([beef, beans, cheese])
    end
  end
end