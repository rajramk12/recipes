require "test_helper"

class ChefSignupInTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "get signup path" do
    get signup_path
    assert_response :success
  end

  test "valid sign up " do
    get signup_path
    assert_difference 'Chef.count', 1 do
      post chefs_path, params: { chef: { chefname: "admin2" , email:"admin@mail.com",
                                         password: 'admin33', password_confirmation: 'admin33' } }
    end
    follow_redirect!
    assert_template 'chefs/show'

  end

  test "reject invalid sign up" do
    get signup_path
    assert_no_difference 'Chef.count' do
      post chefs_path, params: { chef: { chefname: "" , email:"", password: 'superji', password_confirmation: 'superji'}  }
    end
    assert_template 'chefs/new'
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count:0
  end

end
