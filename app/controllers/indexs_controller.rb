class IndexsController < ApplicationController

  def index
    @posts = []
    if @current_user
      user_ids = Following.get_followed_user_ids(current_user.id)
      # Including current user posts
      user_ids.push(@current_user.id)
      @posts = Post.get_followed_user_posts(user_ids).order(created_at: :desc)

    end
  end

end
