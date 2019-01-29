class GetFeedWorkerWorker
  include Sidekiq::Worker

  def perform(user)
	posts = Micropost.where("user_id IN (?) OR user_id = ?", user.following.map(&:id), id).order("created_at DESC")
  	Rails::logger.debug "posts #{posts}"
  	return posts
  end
end
