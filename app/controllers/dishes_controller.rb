class DishesController < ApplicationController
  def show
    @dish = Dish.find(params[:id])
  end

  def update
    dish = Dish.find(params[:id])
    dish.update(dish_params)
    redirect_to chef_path(params[:chef_id])
  end

private
  def dish_params
    params.permit(:chef_id, :name, :description)
  end
end