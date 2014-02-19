class FoodsController < ApplicationController
  def index
  end

  def search
    food_name = params[:food][:name]
    @foods = Food.where("name LIKE ?", "%#{food_name}%")
    render :index
  end
end