require 'test_helper'

class GraphsControllerTest < ActionController::TestCase
  test "should get weekly" do
    get :weekly
    assert_response :success
  end

  test "should get monthly" do
    get :monthly
    assert_response :success
  end

  test "should get quarterly" do
    get :quarterly
    assert_response :success
  end

  test "should get annually" do
    get :annually
    assert_response :success
  end

end
