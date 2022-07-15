class ChefsController < ApplicationController


  def index
    @chefs = Chef.paginate(page: params[:page], per_page: 5)
  end
  def new
    @chef = Chef.new
  end

  def create
    @chef = Chef.new(chef_params)
    if @chef.save
      flash[:success] = 'Account created!'
      redirect_to chef_path(@chef)
    else
      render 'new'
    # break
    end
  end

  def show
    @chef = Chef.find(params[:id])
    @chef_recipes = @chef.recipes.paginate(page: params[:page], per_page: 5)
  end

  def edit
    @chef = Chef.find(params[:id])
  end

  def update
    @chef = Chef.find(params[:id])
    if @chef.update(chef_params)
      flash[:success] = 'Profile successfully updated!'
      redirect_to @chef
    else
      render 'edit'
    end
  end

  def destroy
    @chef = Chef.find(params[:id])
    if @chef.destroy
      flash[:success] = "Chef #{@chef.chefname} and all recipes deleted"
      redirect_to chefs_path
    end
  end

  private
    def chef_params
      params.require(:chef).permit( :chefname, :email, :password, :password_confirmation )
    end

end
