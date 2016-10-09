require 'test_helper'

class ReserveControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get reserve_index_url
    assert_response :success
  end

end
