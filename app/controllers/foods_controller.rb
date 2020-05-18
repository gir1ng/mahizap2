class FoodsController < ApplicationController
  before_action :require_login

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    if @food.save
      flash[:success] = "食品の登録が完了しました"
      redirect_to new_meal_record_url
    else
      render "new"
    end
  end

  def search
    if !(search_name = params[:search_name]).empty?
      @foods = Food.where("search_name LIKE ?", "%#{search_name}%")
    end
    render "meal_records/new"
  end

  private

  def food_params
    params.require(:food).permit(:food_name, :search_name, :quantifier,
                                 :calorie)
  end
end
