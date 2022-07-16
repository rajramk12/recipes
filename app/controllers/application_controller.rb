class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  def current_user
    if session[:chef_id]
      begin
        @current_chef = Chef.find(session[:chef_id])
      rescue ActiveRecord::RecordNotFound => e
        redirect_to root_path
      end
    end
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:danger] = 'You must be logged in!'
      redirect_to root_path
    end
  end
end
