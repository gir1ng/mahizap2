require 'test_helper'

class SecretsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get secrets_index_url
    assert_response :success
  end

  test "should get new" do
    get secrets_new_url
    assert_response :success
  end

end
