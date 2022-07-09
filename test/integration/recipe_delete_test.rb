require "test_helper"

class RecipeDeleteTest < ActionDispatch::IntegrationTest
def setup
  @chef = Chef.create!(chefname:"superji",email:"mymail@mail.com")
  @recipe = Recipe.create(name: " new recipe" , description:"new reciper for upload" , chef:@chef)
end

test "check delete recipe" do
  get recipe_path(@recipe)
  assert_template 'recipes/show'
  assert_select 'a[href=?]', recipe_path(@recipe), text:"Delete Recipe"
  assert_difference 'Recipe.count', -1 do
    delete_recipe(@recipe)
  end
  assert_redirected_to recipes_path
  assert_not flash.empty?
end

end
