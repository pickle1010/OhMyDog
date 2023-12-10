class DogWalker < ApplicationRecord
    has_one_attached :photo
    validates :name, :lastname, :workplace, :service, :contact, presence: true
    validate :photo_attached?

    def photo_attached?
        errors.add(:photo, "debe estar adjunta") unless photo.attached?
    end
    
end
