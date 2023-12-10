class DogWalker < ApplicationRecord
    has_one_attached :photo
    validates :workplace, :service, :contact, presence: true
    validates :name, presence: true, format: { with: /\A[A-Za-z\s]+\z/, message: "solo permite letras" }
    validates :lastname, presence: true, format: { with: /\A[A-Za-z\s]+\z/, message: "solo permite letras" }
    validate :photo_attached?

    def photo_attached?
        errors.add(:photo, "debe estar adjunta") unless photo.attached?
    end
    
end
