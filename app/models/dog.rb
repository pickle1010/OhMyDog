class Dog < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  has_many :clinic_dogs, dependent: :destroy

  enum sex: [:male, :female]
  enum breed: [:labrador, :golden_retriever, :beagle, :bulldog, :rottweiler, :dachshund, :chihuahua, :doberman, :german_shepherd, :boxer, :dogo_argentino, :border_collie]
  
  validates :first_name, :last_name, :breed, :color, :sex, :birthday, presence: true
  validates :first_name, :last_name, :color, format: {with: /\A[^0-9]+\z/, message: "solo permite ingresar letras"}
  validate :birthday_cannot_be_in_the_future
  validate :photo_attached?

  #Pendiente validar nombre del perro segun perros existentes del dueño y cambiar :sex por tipo enum: macho o hembra.
  private

  def birthday_cannot_be_in_the_future
    if birthday.present? && birthday > Date.today
      errors.add(:birthday, "no puede ser una fecha futura")
    end
  end

  def photo_attached?
    errors.add(:photo, "debe estar adjunta") unless photo.attached?
  end

end
