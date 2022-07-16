require "test_helper"

class RecipesTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefname: "super",email:"test@email.com",password:'superji',password_confirmation:'superji')
    @recipe1 = Recipe.create!(name: "Veg Pulao", description: "Rice, Veggies and more", chef: @chef)
    @recipe2 = @chef.recipes.build(name: "Chicken Pulao", description: "Rice, Chicken and more")
    @recipe2.save
  end

  test "read the recipe index page" do
    get recipes_url
    assert_response :success
  end

  test "read recipes/index page" do
    get recipes_path
    assert_template "recipes/index"
    # assert_match @recipe1.name,response.body
    assert_select "a[href=?]", recipe_path(@recipe1),text:@recipe1.name
    # assert_match @recipe2.name, response.body
    assert_select "a[href=?]", recipe_path(@recipe2),text:@recipe2.name
  end

  test "get recipe show " do
    sign_in_as(@chef,'superji')
    get recipe_path(@recipe1)
    assert_response :success
    assert_select "a[href=?]", edit_recipe_path(@recipe1), text: "Edit Recipe"
    # assert_select "a[href=?]", recipe_path(@recipe1),text: "Destroy"
    assert_template "recipes/show"
  end

  test "create valid recipe " do
    sign_in_as(@chef,'superji')
    get new_recipe_path
    assert_template 'recipes/new'
    name = "super recipe "
    desc = "vegetables, sauted , less oil "
    assert_difference 'Recipe.count', 1 do
      post recipes_path, params:{ recipe: {name: name, description: desc} }
    end
    follow_redirect!
    assert_match name.capitalize , response.body
    assert_match desc , response.body
  end
test "create new invalid recipe" do
  sign_in_as(@chef,'superji')
  get new_recipe_path
  assert_template 'recipes/new'
  assert_no_difference 'Recipe.count' do
    post recipes_path , params: { recipe: { name: " " ,
                                         description: " " } }
  end
  assert_template 'recipes/new'
  assert_select 'h2.panel-title'
end

end
