require 'test_helper'

class MealRecordsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get meal_records_new_url
    assert_response :success
  end

  test "should get index" do
    get meal_records_index_url
    assert_response :success
  end

end
