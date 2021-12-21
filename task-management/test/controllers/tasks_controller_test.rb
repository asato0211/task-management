require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest

  test "should get index" do
    get root_url
    assert_response :success
    assert_select "title", "TaskManagement"
  end

  test "should get about" do
    get about_url
    assert_response :success
  end
end