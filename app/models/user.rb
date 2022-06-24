class User < ApplicationRecord
    has_secure_password


    validates :name, {presence: true}
    validates :email, {presence: true, uniqueness: true}

    mount_uploader :image, ImageUploader



    # フォローした、されたの関係
    has_many :relationships, foreign_key: "following_id", dependent: :destroy
    has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy

    # 一覧画面で使う
    # 自分がフォローしている人全員を取得
    has_many :followings, through: :relationships, source: :follower, dependent: :destroy
    # 自分のことをフォローしている人 （＝ 自分から見れば「フォロワー」）全員を取得
    has_many :followers, through: :reverse_of_relationships, source: :following, dependent: :destroy




    def posts
        return Post.where(user_id: self.id)
    end


    # フォローしているか判定
    def followed_by?(user)
        # 今自分(引数のuser)がフォローしようとしているユーザー(レシーバー)がフォローされているユーザー(つまりpassive)の中から、引数に渡されたユーザー(自分)がいるかどうかを調べる
        reverse_of_relationships.find_by(following_id: user.id).present?
    end

    def following?(user)
        relationships.find_by(follower_id: user.id).present?
    end
    # 何人をフォローしている？フォローしている人何人？
    def how_many_followings?
        return relationships.where(following_id: self.id).count
    end
    # 何人にフォローされている？自分のことをフォローしてくれている人何人？
    def how_many_followers?
        return reverse_of_relationships.where(follower_id: self.id).count
    end

end
