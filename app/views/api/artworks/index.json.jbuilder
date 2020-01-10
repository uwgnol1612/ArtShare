@artworks.each do |artwork|
    json.set! artwork.id do 
        json.extract! artwork, :title, :image_url
    end
end 