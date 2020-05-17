class MealRecordsController < ApplicationController
  # session[:result] = [{food_name: 納豆, multiple: 1, calorie: 80}, {food_name: ナッツ, multiple: 10, calorie: 90}]
  def new
    @meal_record = MealRecord.new
    session[:result] = [] if session[:result].nil?
    if multiple = params[:multiple]
      result = { food_name: params[:food_name], quantifier: params[:quantifier], calorie: params[:calorie], multiple: multiple }
      session[:result].push(result)
      redirect_to new_meal_record_url
    end
  end

  def index
    @meal_records = MealRecord.where(user_id: current_user.id).order(created_at: "DESC")
    # @meal_records = current_user.meal_records.order(created_at: DESC)
  end

  def create
    total_calorie = 0
    meal_content = []
    session[:result].each do |r|
      total_calorie += r["calorie"].to_i * r["multiple"].to_f
      meal_content.push(r["food_name"])
    end
    meal_record = current_user.meal_records.build(meal_content: meal_content.join(","), total_calorie: total_calorie)
    session.delete(:result)
    meal_record.save
    redirect_to meal_records_url
  end

  def session_result_delete
    session[:result].delete_at(params[:index].to_i)
    redirect_to new_meal_record_url
  end
end
