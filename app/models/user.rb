class User < ApplicationRecord
    has_secure_password

    has_many :relationships, class_name: :"relationship", foreign_key: :following_id
    has_many :followings, through: :relationships, source: :following_id

    has_many :reverse_of_relationships, class_name: :"relationship", foreign_key: :follower_id
    has_many :followers, through: :reverse_of_relationships, source: :follower_id



    validates :name, {presence: true}
    validates :email, {presence: true, uniqueness: true}


    def posts
        return Post.where(user_id: self.id)
    end

    def is_followed_by?(user)
        reverse_of_relationships.find_by(following_id: user.id).present?
    end

    # フォローしたときの処理
    def follow(user_id)
        relationships.create(follower_id: user_id)
    end

    # フォローを外すときの処理
    def unfollow(user_id)
        relationships.find_by(follower_id: user_id).destroy
    end

    # フォローしているか判定
    def following?(user)
        followings.include?(user)
    end

end
