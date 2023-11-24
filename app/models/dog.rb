class Dog < ApplicationRecord
  belongs_to :user
  has_one :turn_form, dependent: :destroy
  has_one_attached :photo
  has_many :clinic_dogs, dependent: :destroy

  enum sex: [:male, :female]
  enum breed: [:labrador, :golden_retriever, :beagle, :bulldog, :rottweiler, :dachshund, :chihuahua, :doberman, :german_shepherd, :boxer, :dogo_argentino, :border_collie]
  
  validates :first_name, :last_name, :breed, :color, :sex, :birthday, presence: true
  validates :first_name, :last_name, :color, format: {with: /\A[^0-9]+\z/, message: "solo permite ingresar letras"}
  validate :birthday_cannot_be_in_the_future
  validate :photo_attached?

  def age_in_months
    today = Date.today
    age_in_months = (today.year * 12 + today.month) - (birthday.year * 12 + birthday.month)

    # Adjust age if the birthday hasn't occurred yet this month
    age_in_months -= 1 if today.day < birthday.day

    age_in_months
  end

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