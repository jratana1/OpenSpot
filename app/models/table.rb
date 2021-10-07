class Table < ApplicationRecord
    belongs_to :restaurant

    after_create_commit do
        TableCreationNotificationJob.perform_later(self)
    end
end
