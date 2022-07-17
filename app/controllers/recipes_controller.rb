class RecipesController < ApplicationController
  before_action :set_recipe, only: [:edit, :show, :update, :destroy]
  before_action :require_user, except: [:index,:show]
  before_action :require_same_user , only: [:edit, :update, :destroy]

  def index
    @recipes = Recipe.paginate(page: params[:page], per_page: 5)
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
    @recipe.chef = current_user
    if @recipe.save
      flash[:success] = 'Thought uploaded successfully'
      redirect_to recipe_path(@recipe)
    else
      render 'recipes/new'
    end
  end

  def edit
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_param)
      flash[:success] = 'Thought updated successfully'
      redirect_to recipe_path(@recipe)
    else
      render 'edit'
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    if @recipe.destroy
      flash[:success] = 'Thought Deleted'
      redirect_to recipes_path
    end
  end

  private
    def recipe_param
      #white list the parameters
      params.require(:recipe).permit(:name, :description)
    end

    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    def require_same_user
      if current_user != @recipe.chef && !current_user.admin?
        flash[:danger] = 'You can edit your Thoughts only!'
        redirect_to recipes_path
      end
    end


end
