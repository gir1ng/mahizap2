class MealRecordsController < ApplicationController
  before_action :require_login
  before_action :correct_user, only: [:edit, :update]

  def add_food
    @meal_record = MealRecord.new
    session[:result] = [] if session[:result].nil?
    if multiple = params[:multiple]
      result = { food_name: params[:food_name], quantifier: params[:quantifier], calorie: params[:calorie], multiple: multiple }
      session[:result].push(result)
      flash[:success] = "#{params[:food_name]}を追加しました"
      # redirect_to add_food_url
      redirect_back_or add_food_url
    end
  end

  def index
    @meal_records = MealRecord.where(user_id: current_user.id).order(created_at: "DESC")
  end

  def create
    total_calorie = 0
    meal_content = []
    session[:result].each do |r|
      total_calorie += r["calorie"].to_i * r["multiple"].to_f
      meal_content.push(r["food_name"])
    end
    meal_record = current_user.meal_records.build(meal_content: meal_content.join(","), total_calorie: total_calorie.to_i)
    session.delete(:result)
    meal_record.save
    redirect_to meal_records_url
  end

  def session_result_delete
    session[:result].delete_at(params[:index].to_i)
    redirect_back_or add_food_url
  end

  def edit
  end

  def update
    if @meal_record.update(meal_record_params)
      flash[:success] = "更新しました"
      redirect_to meal_records_url
    else
      render "edit"
    end
  end

  private

  def meal_record_params
    params.require(:meal_record).permit(:meal_content, :total_calorie)
  end

  def correct_user
    @meal_record = MealRecord.find(params[:id])
    redirect_to(root_url) unless @meal_record.user_id == current_user.id
  end
end
