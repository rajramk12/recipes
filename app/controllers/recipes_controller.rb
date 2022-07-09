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

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_param)
      flash[:success] = 'Recipe updated successfully'
      redirect_to recipe_path(@recipe)
    else
      render 'edit'
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    if @recipe.destroy
      flash[:success] = 'Recipe Deleted'
      redirect_to recipes_path
    end
  end

  private
    def recipe_param
      #white list the parameters
      params.require(:recipe).permit(:name, :description)
    end
end
