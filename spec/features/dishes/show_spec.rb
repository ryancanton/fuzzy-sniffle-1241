require 'rails_helper'

RSpec.describe 'A dishes show page' do

  before(:each) do
    @chef = Chef.create!(name: 'Chef')
    @chili = @chef.dishes.create!(name: 'Chefs Chili', description: 'The famous schoolhouse chili')
    @beef = Ingredient.create!(name: 'Ground Beef', calories: 123)
    @beans = Ingredient.create!(name: 'Baked Beans', calories: 74)
    @cheese = Ingredient.create!(name: 'Mixed Cheese', calories: 104)
    DishIngredient.create!(ingredient_id: @beef.id, dish_id: @chili.id)
    DishIngredient.create!(ingredient_id: @beans.id, dish_id: @chili.id)
    DishIngredient.create!(ingredient_id: @cheese.id, dish_id: @chili.id)

  end
  it 'contains the dishes name and description' do
    visit dish_path(@dish)

    expect(page).to have_content(@chili.name)
    expect(page).to have_content(@chili.description)
  end

  it 'contains a list of all ingredients in the dish' do
    visit dish_path(@dish)

    expect(page).to have_content(@beef.name)
    expect(page).to have_content(@beans.name)
    expect(page).to have_content(@cheese.name)
  end

  it 'contains a total calorie count for the dish' do
    visit dish_path(@dish)

    expect(page).to have_content("Total Calories: 301")
  end

  it 'contains the chefs name' do
    visit dish_path(@dish)

    expect(page).to have_content(@chef.name)
  end
end