class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end
  def show
    @recipe = Recipe.find(params[:id])
  end
  #  protected
  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_param)
    @recipe.chef = Chef.first
    if @recipe.save
      flash[:success] = 'Recipe uploaded successfully'
      redirect_to recipe_path(@recipe)
    else
      render 'recipes/new'
    end
  end


  private
    def recipe_param
      #white list the parameters
      params.require(:recipe).permit(:name, :description)
    end
end
