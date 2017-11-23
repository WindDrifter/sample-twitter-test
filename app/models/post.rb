class Post < ApplicationRecord
  belongs_to :user
  validates :content, presence: true, length: { maximum: 140 }
  def get_username
    user = User.find(self.user_id)
    return user.username
  end
  class << self
    def get_followed_user_posts(users)
      result = Post.where(user_id: users)
      return result
    end
  end
end
