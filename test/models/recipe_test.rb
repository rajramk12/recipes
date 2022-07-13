require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  def setup
    @chef = Chef.create!(chefname:"testuser",email:"tuser@mail.com",password:'testuser',password_confirmation:'testuser')
    @recipe = @chef.recipes.build(name: "veg pulao",description: "Veg Biriyani" )
  end
  test "valid recipe" do
    assert @recipe.valid?
  end

  test "checking chef foreign key " do
    @recipe.chef_id = nil
    assert_not @recipe.valid?
  end

  test "name is mandatory" do
    @recipe.name =""
    assert_not @recipe.valid?
  end

  test "desc is mandatory" do
    @recipe.description =""
    assert_not @recipe.valid?
  end

  test "desc more than 10 char" do
    @recipe.description = 'a'*13
    assert @recipe.valid?
  end

  test "desc less than 500 char" do
    @recipe.description = 'a'*401
    assert @recipe.valid?
  end

end
