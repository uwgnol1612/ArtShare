class Api::CommentsController < ApplicationController
    def index
        if params[:user_id]
            @comments = Comment.where(user_id: params[:user_id])
        elsif params[:artwork_id]
            @comments = Comment.where(artwork_id: params[:artwork_id])
        else
            @comments = Comment.all
        end
    end

    def create
        @comment = Comment.new(comment_params)
        if @comment.save
            render 'api/comments/show', status: 201
        else
            render json: @comment.errors.full_messages, status: 422 
        end
    end 

    def destroy
        @comment = Comment.find(params[:id])
        @comment.destroy
        render 'api/comments/show'
    end

    def like
        @like = Like.new(user_id: params[:user_id], :likeable_id: params[:id], :likeable_type: 'Comment')
        if @like.save
            render json: @like
        else
            render json: @like.errors.full_messages, status: 422
        end
    end

    def unlike
        @like = Like.find_by(user_id: params[:user_id], likeable_id: params[:id], likeable_type: 'Comment')
        if @like.destroy
            render json: @like
        else
            render json: @like.errors.full_messages, status: 422
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:artwork_id, :user_id, :body)
    end 

end 