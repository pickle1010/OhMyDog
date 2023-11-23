class Dog < ApplicationRecord
  belongs_to :user
  has_one :turn_form
  has_one_attached :photo

  enum sex: [:male, :female]
  enum breed: [:labrador, :golden_retriever, :beagle, :bulldog, :rottweiler, :dachshund, :chihuahua, :doberman, :german_shepherd, :boxer, :dogo_argentino, :border_collie]
  
  validates :first_name, :last_name, :breed, :color, :sex, :birthday, presence: true
  validates :first_name, :last_name, :color, format: {with: /\A[^0-9]+\z/, message: "solo permite ingresar letras"}
  validate :photo_attached?

  #Pendiente validar nombre del perro segun perros existentes del dueño y cambiar :sex por tipo enum: macho o hembra.
  private

  def photo_attached?
    errors.add(:photo, "debe ser adjuntada") unless photo.attached?
  end

end
