class SessionsController < ApplicationController
  def new
    if signed_in?
      redirect_to root_url
    end
  end

  def create
  	user = User.find_by(email: session_params[:email].downcase)
  	if user && user.authenticate(session_params[:password])
  		sign_in user
      redirect_back_or user
  	else
  		flash.now[:error] = "Im sorry to say this to you, hero, but either you forgot your name or you dont know your secret word"
  		render :new
  	end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

  private
  	def session_params
  		params[:session]
  	end
end
