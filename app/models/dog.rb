class Dog < ApplicationRecord
  belongs_to :user
  has_one_attached :photo

  validates :first_name, presence: true, format: {with: /\A[^0-9]+\z/, message: "solo permite ingresar letras"}    
  validates :last_name, presence: true, format: {with: /\A[^0-9]+\z/, message: "solo permite ingresar letras"}    
  validates :breed, presence: true, format: {with: /\A[^0-9]+\z/, message: "solo permite ingresar letras"}   
  validates :color, presence: true, format: {with: /\A[^0-9]+\z/, message: "solo permite ingresar letras"}   
  validates :sex, presence: true, format: {with: /\A[^0-9]+\z/, message: "solo permite ingresar letras"}   
  validates :birthday, presence: true  
  validate :photo_attached?

  private

  def photo_attached?
    errors.add(:photo, "debe estar adjunta") unless photo.attached?
  end

end
