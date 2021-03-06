class Api::UsersController < ApplicationController
    def index
        if params[:query]
            @users = User.where('username LIKE ?', "%#{params[:query]}%")
        else 
            @users = User.all
        end
    end

    def create
        @user = User.new(user_params)
        if @user.save
            render 'api/users/show'
        else
            render json: @user.errors.full_messsages, status: 422
        end 
    end

    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            render 'api/users/show'
        else
            render json: @user.errors.full_messsages, status: 422
        end 
    end

    def show
        @user = User.find(params[:id])
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
        render 'api/users/show'
    end

    private

    def user_params
        params.require(:user).permit(:username)
    end 
end
