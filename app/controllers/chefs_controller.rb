class ChefsController < ApplicationController
  before_action :get_chef, only: [:show,:edit,:update,:destroy]
  before_action :require_same_user, only: [:edit,:update,:destroy]
  before_action :require_admin , only: [:destroy]

  def index
    @chefs = Chef.paginate(page: params[:page], per_page: 5)
  end
  def new
    @chef = Chef.new
  end

  def create
    @chef = Chef.new(chef_params)
    if @chef.save
      session[:chef_id] = @chef.id
      flash[:success] = 'Account created!'
      redirect_to chef_path(@chef)
    else
      render 'new'
    # break
    end
  end

  def show
    @chef_recipes = @chef.recipes.paginate(page: params[:page], per_page: 5)
  end

  def edit
  end

  def update
    if @chef.update(chef_params)
      flash[:success] = 'Profile successfully updated!'
      redirect_to @chef
    else
      render 'edit'
    end
  end

  def destroy
    if !@chef.admin?
      if @chef.destroy
        flash[:success] = "User #{@chef.chefname} and all thoughts are deleted"
        session[:chef_id] = nil
        redirect_to chefs_path
      end
    end
  end

  private
    def chef_params
      params.require(:chef).permit( :chefname, :email, :password, :password_confirmation )
    end

    def get_chef
      @chef = Chef.find(params[:id])
    end

    def require_same_user
      if logged_in? && current_user != @chef && !current_user.admin?
        flash[:danger] = 'You can edit your profile only!'
        redirect_to @chef
      end
    end

    def require_admin
      if logged_in? && !current_user.admin?
        flash[:danger] = 'Restricted action! Check with Admin Team'
        redirect_to chefs_path
      end
    end

end
