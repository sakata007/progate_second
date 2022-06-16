class User < ApplicationRecord
    has_secure_password


    validates :name, {presence: true}
    validates :email, {presence: true, uniqueness: true}

    # フォローした、されたの関係
    has_many :relationships, foreign_key: "following_id"
    has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "follower_id"

    # 一覧画面で使う
    # 自分がフォローしている人全員を取得
    has_many :followings, through: :relationships, source: :follower
    # 自分のことをフォローしている人 （＝ 自分から見れば「フォロワー」）全員を取得
    has_many :follower, through: :reverse_of_relationships, source: :following




    def posts
        return Post.where(user_id: self.id)
    end


    # フォローしているか判定
    def followed_by?(user)
        # 今自分(引数のuser)がフォローしようとしているユーザー(レシーバー)がフォローされているユーザー(つまりpassive)の中から、引数に渡されたユーザー(自分)がいるかどうかを調べる
        relationships.find_by(following_id: user.id).present?
    end

end
