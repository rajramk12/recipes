require "test_helper"

class RecipesEditTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefname:"testuser",email:"testmail@mail.com",password:'testuser', password_confirmation:'testuser')
    @recipe = Recipe.create(name:"newrecipe", description:"new recipe created", chef:@chef)
  end
  test "reject invalid recipe" do
    sign_in_as(@chef,'testuser')
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    patch recipe_path(@recipe), params: {recipe: { name:"", description: "somerandom description"} }
    assert_template 'recipes/edit'
    # assert_select 'h2.panel-name'
    # assert_select 'div.panel-body'
  end

  test "valid recipe update2" do
    sign_in_as(@chef,'testuser')
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    upd_name = "Update name "
    upd_desc = "Correct some description"
    patch recipe_path(@recipe), params: { recipe: { name: upd_name, description: upd_desc } }
    assert_redirected_to @recipe
    assert_not flash.empty?
    @recipe.reload
    assert_equal @recipe.name, upd_name
    assert_equal @recipe.description , upd_desc
  end

end
