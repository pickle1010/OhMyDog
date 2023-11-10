class User < ApplicationRecord
  has_many :dogs, dependent: :destroy
  enum role: [:client, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :client
  end

  # Include default devise modules. Others available are:
  # :confirmable, :registerable, :rememberable, :lockable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, 
         :validatable, :timeoutable

  validates :dni, :first_name, :last_name, :address, presence: true
  validates :dni, uniqueness: true, numericality: { greater_than: 0 }
end
