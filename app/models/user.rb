class User < ApplicationRecord
    has_many :likes, dependent: :destroy
    has_many :liked_restaurants, through: :likes, source: :restaurant

    has_many :restaurants
end
