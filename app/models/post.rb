class Post < ApplicationRecord
    validates :content, {presence: true, length: {maximum:140} }
    validates :user_id, {presence: true}

    def user
        return User.find_by(id:self.id)
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
