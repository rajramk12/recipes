class RecipesController < ApplicationController
  before_action :set_recipe, only: [:edit, :show, :update, :destroy, :like]
  before_action :require_user, except: [:index,:show]
  before_action :require_same_user , only: [:edit, :update, :destroy]
  before_action :require_user_like, only: [:like]

  def index
    @recipes = Recipe.paginate(page: params[:page], per_page: 5)
  end
  def show
   @comments = @recipe.comments.paginate(page: params[:page],per_page: 5 )
   @comment = Comment.new
  end
  #  protected
  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_param)
    @recipe.chef = current_user
    if @recipe.save
      flash[:success] = 'Recipe uploaded successfully'
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
      flash[:success] = 'Recipe updated successfully'
      redirect_to recipe_path(@recipe)
    else
      render 'edit'
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    if @recipe.destroy
      flash[:success] = 'Recipe is Deleted'
      redirect_to recipes_path
    end
  end

  def like
    like = Like.create(like: params[:like], chef: current_user, recipe: @recipe)
    if like.valid?
      flash[:success] = "Your selection was succesful"
      redirect_to recipe_path(@recipe)
    else
      flash[:danger] = "You can only like/dislike a recipe once"
      redirect_to recipe_path(@recipe)
    end
  end


  protected
  def require_user_like
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to :back
    end
  end

  private
    def recipe_param
      #white list the parameters
      params.require(:recipe).permit(:name, :description,ingredient_ids:[])
    end

    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    def require_same_user
      if current_user != @recipe.chef && !current_user.admin?
        flash[:danger] = 'You can edit your Recipes only!'
        redirect_to recipes_path
      end
    end

end
