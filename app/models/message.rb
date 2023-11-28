class Message < ApplicationRecord
  has_noticed_notifications

  belongs_to :user
  belongs_to :dog, optional: true
  belongs_to :clinic_dog, optional: true

  after_create_commit :notify_user

  def notify_user
    MessageNotification.with(message: self).deliver_later(user)
  end
end