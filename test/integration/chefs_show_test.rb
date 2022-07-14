require "test_helper"

class ChefsShowTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @chef = Chef.create!(chefname:"testuser",email:"testmail@mail.com",password:'testuser', password_confirmation:'testuser')
    @recipe = Recipe.create(name:"newrecipe", description:"new recipe created", chef:@chef)
    @recipe2 = Recipe.create(name:"newrecipe2", description:"new recipe created", chef:@chef)
  end

  test "show recipes per chef" do
    get chef_path(@chef)
    assert_template 'chefs/show'
    assert_select 'a[href=?]', recipe_path(@recipe), text: @recipe.name
    assert_select 'a[href=?]', recipe_path(@recipe2), text: @recipe2.name

    assert_match @recipe.description , response.body
    assert_match @recipe2.description , response.body
  end
end
