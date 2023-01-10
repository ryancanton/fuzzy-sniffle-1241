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
    visit chef_path(@chef.id)

    expect(page).to have_content("New Dish")
    fill_in('Name', with: 'Chefs Waffles')
    fill_in('Description', with: 'The famous schoolhouse waffles')
    click_button('Create Dish')

    expect(current_path).to eq(chef_path(@chef.id))
    expect(page).to have_content('Chefs Waffles')
  end
end