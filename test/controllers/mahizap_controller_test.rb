require 'test_helper'

class MahizapControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get mahizap_index_url
    assert_response :success
  end

end
