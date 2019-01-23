class StaticPagesController < ApplicationController
  def home
    @micropost = current_user.microposts.build if logged_in?
  	@title = "Home"
  end

  def help
  	@title = "Help"
  end

  def about
  	@title = "About"
  end

  def contact
  	@title = "Contact"
  end
end
