require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  def setup
    @recipe = Recipe.new(name: "veg pulao",description: "Veg Biriyani")
  end 
  test "valid recipe" do
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
    assert_not @recipe.valid?
  end 
  test "desc less than 500 char" do
    @recipe.description = 'a'*401
    assert_not @recipe.valid?
  end 

end 