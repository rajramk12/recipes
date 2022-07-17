class IngredientsController < ApplicationController
  before_action :set_ingredient, only: [:edit,:update,:show]
  before_action :require_admin, except: [:show,:index]
  def index
    @ingredients = Ingredient.paginate(page: params[:page],per_page:5)
  end

  def show
    @in_recipes = @ingredient.recipes.paginate(page: params[:page],per_page:5)
  end

  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    if @ingredient.save
      flash[:success] = 'Ingredient added successfully'
      redirect_to @ingredient
    else
      render 'new'
    end
  end


  def update
    if Ingredient.update(ingredient_params)
      flash[:success] = 'Ingredient updated successfully'
      redirect_to @ingredient
    else
      render 'edit'
    end
  end

  def edit

  end

  def destroy
  end

  private
    def set_ingredient
      @ingredient = Ingredient.find(params[:id])
    end

    def ingredient_params
      params.require(:ingredient).permit(:name)
    end

    def require_admin
      if !logged_in? || ( logged_in? && !current_user.admin?)
        flash[:danger] = 'Alert ! It is Admin functionality! contact Admin team'
        redirect_to ingredients_path
      end
    end
end
