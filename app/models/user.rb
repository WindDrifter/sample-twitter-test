class User < ApplicationRecord
  has_secure_password
  validates :username, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true
  validates :email, presence: true
  has_many :followings, dependent: :destroy

  def is_following(other_user)
    following = Following.find_by(following: self.id, user_id: other_user.id)
    return following
  end

end
