class LikesController < ApplicationController
    # before_actionに「:authenticate_user」を追加してください
    before_action :authenticate_user
    
    # createアクションを追加してください
    def create
        @like = Like.new(user_id: @current_user.id, post_id: params[:post_id])
        @like.save
        redirect_to request.referer
    end

    def destroy
        @like = Like.find_by(user_id:@current_user.id, post_id: params[:post_id])
        @like.destroy
        redirect_to request.referer
    end
    
end