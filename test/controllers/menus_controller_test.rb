require "test_helper"

class MenusControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_menu_url
    assert_response :success
  end
end
