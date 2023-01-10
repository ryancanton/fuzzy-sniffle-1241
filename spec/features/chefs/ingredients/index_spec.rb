require 'rails_helper'

RSpec.describe 'A chefs ingredients index page' do
  it 'contains a list of every ingredient a chef uses' do
    chef = Chef.create!(name: 'Chef')
    chili = chef.dishes.create!(name: 'Chefs Chili', description: 'The famous schoolhouse chili')
    taco_meat = chef.dishes.create!(name: 'Chefs Taco Meat', description: 'The famous schoolhouse taco meat')
    beef = Ingredient.create!(name: 'Ground Beef', calories: 123)
    beans = Ingredient.create!(name: 'Baked Beans', calories: 74)
    cheese = Ingredient.create!(name: 'Mixed Cheese', calories: 104)
    spices = Ingredient.create!(name: 'Taco Seasoning', calories: 12)
    DishIngredient.create!(ingredient_id: beef.id, dish_id: chili.id)
    DishIngredient.create!(ingredient_id: beans.id, dish_id: chili.id)
    DishIngredient.create!(ingredient_id: cheese.id, dish_id: chili.id)
    DishIngredient.create!(ingredient_id: beef.id, dish_id: taco_meat.id)
    DishIngredient.create!(ingredient_id: cheese.id, dish_id: taco_meat.id)
    DishIngredient.create!(ingredient_id: spices.id, dish_id: taco_meat.id)

    visit chef_ingredients_path(chef.id)

    expect(page).to have_content(beef.name)
    expect(page).to have_content(cheese.name)
    expect(page).to have_content(beans.name)
    expect(page).to have_content(spices.name)
  end
end