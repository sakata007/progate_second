class Post < ApplicationRecord
    validates :content, {presence: true, length: {maximum:140} }
    validates :user_id, {presence: true}

    belongs_to :user

    # mount_uploader :image, :ImageUploader

    def user
        return User.find_by(id:self.user_id)
    end

    # いいね数カウントのため追記
    def likes_count
        return Like.where(post_id:self.id).count
    end

    # フォローしたときの処理
    # def follow(user_id)
    #     relationships.create(follower_id: user_id)
    # end

    # # フォローを外すときの処理
    # def unfollow(user_id)
    #     relationships.find_by(follower_id: user_id).destroy
    # end

    # # フォローしているか判定
    # def following?(user)
    #     followings.include?(user)
    # end
    

end
