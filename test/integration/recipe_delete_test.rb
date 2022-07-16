require "test_helper"

class RecipeDeleteTest < ActionDispatch::IntegrationTest
def setup
  @chef = Chef.create!(chefname:"superji",email:"mymail@mail.com",password:'superji',password_confirmation:'superji')
  @recipe = Recipe.create(name: " new recipe" , description:"new reciper for upload" , chef:@chef)
end

test "check delete recipe" do
  sign_in_as(@chef,'superji')
  get recipe_path(@recipe)
  assert_template "recipes/show"
  assert_select "a[href=?]", recipe_path(@recipe), text:"Destroy"
  assert_difference "Recipe.count", -1 do
    delete recipe_path(@recipe)
  end
  assert_redirected_to recipes_path
  assert_not flash.empty?
end

end
