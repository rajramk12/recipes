require "test_helper"

class ChefLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @chef = Chef.create!(chefname:'chef',email:'chef22@mail.com',password:'password')
  end

  test "invalid login reject" do
    get login_path
    assert_template "sessions/new"
    post login_path , params: { session: { email: "", password:""} }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
    assert_select 'a[href=?]', login_path
    assert_select 'a[href=?]', logout_path, count: 0
  end

  test "valid login success" do
    get login_path
    assert_template "sessions/new"
    post login_path, params: { session: { email: @chef.email, password: @chef.password } }
    assert_redirected_to @chef
    follow_redirect!
    assert_template 'chefs/show'
    assert_not flash.empty?
    # assert_equal 'a[href=?]', logout_path
    assert_select 'a[href=?]', login_path, count: 0
  end

end
