class User < ApplicationRecord
    has_secure_password

    has_many :relationships, foreign_key: :following_id
    has_many :followings, through: :relationships, source: :follower

    has_many :reverse_of_relationships, class_name: :"relationship", foreign_key: :follower_id
    has_many :followers, through: :reverse_of_relationships, source: :following



    validates :name, {presence: true}
    validates :email, {presence: true, uniqueness: true}


    def posts
        return Post.where(user_id: self.id)
    end

    def is_followed_by?(user)
        reverse_of_relationships.find_by(following_id: user.id).present?
    end

end
