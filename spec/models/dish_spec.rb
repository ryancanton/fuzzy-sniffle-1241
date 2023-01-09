require 'rails_helper'

RSpec.describe Dish, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
  end

  describe "relationships" do
    it {should belong_to :chef}
    it {should have_many :dish_ingredients}
    it {should have_many(:ingredients).through(:dish_ingredients)}
  end

  describe "#calorie_count" do
    it 'returns the total calorie count of a dish' do
      chef = Chef.create!(name: 'Chef')
      chili = chef.dishes.create!(name: 'Chefs Chili', description: 'The famous schoolhouse chili')
      beef = Ingredient.create!(name: 'Ground Beef', calories: 123)
      beans = Ingredient.create!(name: 'Baked Beans', calories: 74)
      cheese = Ingredient.create!(name: 'Mixed Cheese', calories: 104)
      DishIngredient.create!(ingredient_id: beef.id, dish_id: chili.id)
      DishIngredient.create!(ingredient_id: beans.id, dish_id: chili.id)
      DishIngredient.create!(ingredient_id: cheese.id, dish_id: chili.id)

      expect(chili.calorie_count).to eq(301)
    end
  end

  describe '#chef_name' do
    it 'returns the name of the chef that created the dish' do
      chef = Chef.create!(name: 'Chef')
      chili = chef.dishes.create!(name: 'Chefs Chili', description: 'The famous schoolhouse chili')

      expect(chili.chef_name).to eq("Chef")
    end
  end
end

