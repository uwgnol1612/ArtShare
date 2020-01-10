class Api::ArtworksController < ApplicationController
    def index
        if params[:user_id]
            @artworks = Artwork.artworks_for_user(params[:user_id])
        else
            @artworks = Artwork.all
        end
    end

    def create
        @artwork = Artwork.new(artwork_params)
        if @artwork.save
            render 'api/artworks/show'
        else
            render json: @artwork.errors.full_messages, status: 422
        end 
    end

    def update
        @artwork = Artwork.find(params[:id])
        if @artwork.update(artwork_params)
            render 'api/artworks/show'
        else
            render json: @artwork.errors.full_messages, status: 422
        end 
    end

    def show
        @artwork = Artwork.find(params[:id])
    end

    def destroy
        @artwork = Artwork.find(params[:id])
        @artwork.destroy
        render 'api/artwork/show'
    end

    private

    def artwork_params
        params.require(:artwork).permit(:title, :image_url, :artist_id)
    end 
end