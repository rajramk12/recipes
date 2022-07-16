require "test_helper"

class ChefsListingTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @chef1 = Chef.create!(chefname:'userr1', email:'userr1@email.com',password:'pasword',password_confirmation:'pasword')
    @chef2 = Chef.create!(chefname:'userr2', email:'userr2@email.com',password:'pasword',password_confirmation:'pasword')
    @admin = Chef.create!(chefname:'admin',email:'admin@mail.com',password:'password', password_confirmation:'password',admin:true)
  end

  test "list all chefs" do
    get chefs_path
    assert_template 'chefs/index'
    assert_select "a[href=?]", chef_path(@chef1), text: @chef1.chefname.capitalize
    assert_select "a[href=?]", chef_path(@chef2), text: @chef2.chefname.capitalize
    # assert_match @chef1.chefname, response.body
    # assert_match @chef2.chefname, response.body
  end

  test "delete chef" do
    sign_in_as(@admin,'password')
    get chefs_path
    assert_template 'chefs/index'
    assert_difference 'Chef.count' , -1 do
      delete chef_path(@chef2)
    end
    assert_redirected_to chefs_path
    assert_not flash.empty?

  end

end
