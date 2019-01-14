class SessionsController < ApplicationController
  def new
  	@title = "Log in"
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)

  	if user && user.authenticate(params[:session][:password])
  		log_in user
  		redirect_to user
  	else
  		flash.now[:danger] = "Invalid email/password combo"
  		render 'new'
  	end
  end
end