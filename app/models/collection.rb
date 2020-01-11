class Collection < ApplicationRecord
    validates :name, presence: true

    belongs_to :user,
        foreign_key: :user_id,
        class_name: 'User'
    
    has_many :artwork_collections
    has_many :artworks,
        through: :artwork_collections,
        source: :artwork
end
