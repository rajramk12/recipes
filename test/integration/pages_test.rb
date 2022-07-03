require "test_helper"

class PagesTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "should_get_home" do
    get pages_home_url 
      assert_response :success 
    end

    test "should_get_root" do
      get root_url
      assert_response :success 
    end
end
