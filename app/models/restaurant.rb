class Restaurant < ApplicationRecord
    has_many :likes, dependent: :destroy
    has_many :liking_users, through: :likes, source: :user

    belongs_to :owner, class_name: "User", foreign_key: "user_id"

    has_many :tables
end
