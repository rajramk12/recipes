require "test_helper"

class EditChefTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @chef = Chef.create!(chefname:"testuser",email:"testmail@mail.com",password:'testuser', password_confirmation:'testuser')
  end

  test "reject invalid chef edit" do
    sign_in_as(@chef,'testuser')
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params:{ chef: { chefname:'', email:'usermail@email.com'}}
    assert_template 'chefs/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  test "check valid chef edit " do
    sign_in_as(@chef,'testuser')
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params:{ chef: { chefname:'2testuser', email:'usermail@email.com'}}
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    # assert_template 'chef/show'
    assert_match @chef.chefname , '2testuser'
    assert_match @chef.email , 'usermail@email.com'
  end

end
