require "test_helper"

class EditChefTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @chef = Chef.create!(chefname:"testuser",email:"testmail@mail.com",password:'testuser', password_confirmation:'testuser')
    @chef2 = Chef.create!(chefname:"testuser2",email:"testmail3@mail.com",password:'testuser', password_confirmation:'testuser')
    @admin = Chef.create!(chefname:"admin",email:"testmail2@mail.com",password:'testuser', password_confirmation:'testuser',admin:true)
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

  test "check valid admin edit " do
    sign_in_as(@admin,'testuser')
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params:{ chef: { chefname:'testuser3', email:'testmail@mail.com'}}
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    # assert_template 'chef/show'
    assert_match @chef.chefname , 'testuser3'
    assert_match @chef.email , 'testmail@mail.com'
  end

  test "check invalid non admin edit " do
    sign_in_as(@chef2,'testuser')
    upd_name='superchef'
    upd_pwd='superchef'
    patch chef_path(@chef), params:{ chef: { chefname:upd_name, email:upd_pwd}}
    assert_redirected_to @chef
    assert_not flash.empty?
    assert_match @chef.chefname , 'testuser'
    assert_match @chef.email , "testmail@mail.com"
  end


end
