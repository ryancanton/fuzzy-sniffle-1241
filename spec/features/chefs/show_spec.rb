require 'rails_helper'

RSpec.describe "A chef show page" do

  before(:each) do
    @chef = Chef.create!(name: 'Chef')
    @chili = @chef.dishes.create!(name: 'Chefs Chili', description: 'The famous schoolhouse chili')
    @mac = @chef.dishes.create!(name: 'Chefs Mac n Cheese', description: 'The famous schoolhouse mac')
    @pudding = @chef.dishes.create!(name: 'Chefs Puddin', description: 'The famous schoolhouse puddin')
  end
  it 'contains the chef name and a list of all dishes belonging to that chef' do
    visit chef_path(@chef.id)

    expect(page).to have_content(@chef.name)
    expect(page).to have_content(@chili.name)
    expect(page).to have_content(@mac.name)
    expect(page).to have_content(@pudding.name)

  end

  it 'contains a form that creates a new dish for the chef' do
    other_chef = Chef.create!(name: "other_chef")
    dish = other_chef.dishes.create!(name: 'Chefs Waffles', description: 'The famous schoolhouse waffles')
    visit chef_path(@chef.id)

    expect(page).to have_content("Add Existing Dish to #{@chef.name}")
    fill_in('id', with: dish.id)
    click_button('Add Dish')

    expect(current_path).to eq(chef_path(@chef.id))
    expect(page).to have_content('Chefs Waffles')
  end
end