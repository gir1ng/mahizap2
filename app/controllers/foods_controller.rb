class FoodsController < ApplicationController
  before_action :require_login

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    if @food.save
      flash[:success] = "食品の登録が完了しました"
      redirect_to new_food_url
    else
      render "new"
    end
  end

  def search
    if !(search_name = params[:search_name]).empty?
      @foods = Food.where("search_name LIKE ?", "%#{search_name}%")
      store_location
    end
    @meal_record = MealRecord.new
    render "meal_records/new"
  end

  def edit
    @food = Food.find(params[:id])
  end

  def update
    @food = Food.find(params[:id])
    if @food.update(food_params)
      flash[:success] = "更新しました"
      redirect_back_or new_meal_record_url
    else
      render "edit"
    end
  end

  private

  def food_params
    params.require(:food).permit(:food_name, :search_name, :quantifier,
                                 :calorie, :sugar)
  end
end
