class User < ApplicationRecord
  has_many :dogs, dependent: :destroy
  has_many :turn_forms, dependent: :destroy
  has_many :messages
  has_many :meetings
  has_many :notifications, as: :recipient, dependent: :destroy
  
  accepts_nested_attributes_for :dogs

  enum role: [:client, :admin] , _default: :client 

  # Include default devise modules. Others available are:
  # :confirmable, :registerable, :rememberable, :timeoutable, :lockable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :validatable

  validates :dni, :first_name, :last_name, :address, presence: true
  validates :first_name, :last_name, format: {with: /\A[^0-9]+\z/, message: "solo puede tener letras"}
  validates :dni, uniqueness: true, numericality: { greater_than: 0 }
end
