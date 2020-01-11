class CollectionsController < ApplicationController
    def index
        @collections = Collection.where(user_id: params[:user_id])
    end 

    def create
        @collection = Collection.new(collection_params)

        if @collection.save
            render json: @collection, status: 201
        else
            render json: @collection.errors.full_messages, status: 422
        end
    end

    def show
        @collection = Collection.find(params[:id])
    end

    def destroy
        @collection = Collection.find(params[:id])
        @collection.destroy
        render json: @collection
    end

    def add_artwork
        artwork_collection = Artwork_collection.new(
            artwork_id: params[:artwork_id]
            collection_id: params[:collection_id]
        )
        if artwork_collection.save
            render json: artwork_collection, status: 201
        else
            render json: artwork_collection.errors.full_messages, status: 422
        end
    end

    def remove_artwork
        artwork_collection = ArtworkCollection.find_by(
            artwork_id: params[:artwork_id]
            collection_id: params[:collection_id]
        )
        artwork_collection.destroy
        render json: collection
    end


    private 
    def collection_params
        params.require(:collection).permit(:user_id, :name)
    end
end