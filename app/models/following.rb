class Following < ApplicationRecord
  belongs_to :user
  class << self
    def get_followed_user_ids(user_id)
      following_users = self.where(user_id: user_id)
      result = []
      following_users.each { |following_user|
        if following_user.following
          result.push(following_user.following)
        end}
      
      return result

    end
  end
end
