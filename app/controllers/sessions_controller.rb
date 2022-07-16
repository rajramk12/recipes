class SessionsController < ApplicationController
  def new

  end

  def create
    chef = Chef.find_by(email: params[:session][:email].downcase)
      if chef && chef.authenticate(params[:session][:password])
        session[:chef_id] = chef.id
        flash[:success] = 'You have Logged In successfully'
        redirect_to chef_path(chef)
      else
        flash.now[:danger] = "Invalid Email/Password"
        render 'new'
      end
  end

  def destroy
      session[:chef_id] = nil
      flash[:success] = 'Logged out successfully'
      redirect_to root_path
  end

end
