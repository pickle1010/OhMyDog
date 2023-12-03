class WantedPost < ApplicationRecord
  belongs_to :user
  has_one_attached :photo

  validates :body, :photo, presence: true
end
