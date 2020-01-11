class Api::ArtworkSharesController < ApplicationController
    def create
        @share = ArtworkShare.new(artwork_share_params)
        if @share.save
            render json: @share, status: 201
        else
            render json: @share.errors.full_messages, status: 422 
        end
    end 

    def destroy
        @share = ArtworkShare.find(params[:id])
        @share.destroy
        render json: @share
    end

    def favorite
        @share = ArtworkShare.find_by(id: params[:id], viewer_id: params[:user_id])
        @share.favorite = true
        @share.save
        render json: @share
    end

    def unfavorite
        @share = ArtworkShare.find_by(id: params[:id], viewer_id: params[:user_id])
        @share.favorite = false
        @share.save
        render json: @share
    end

    private

    def artwork_share_params
        params.require(:artwork_share).permit(:artwork_id, :viewer_id)
    end 

end 