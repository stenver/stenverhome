class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  private

    def signed_in_user
      store_location
      redirect_to signin_url, notice: "Please identify yourself" unless signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user) or current_user.admin?
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
