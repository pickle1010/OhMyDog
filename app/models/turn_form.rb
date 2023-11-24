class TurnForm < ApplicationRecord
  belongs_to :user
  belongs_to :dog

  enum schedule: [:morning, :afternoon]

  validates :dateCons , presence: true
  validates :schedule, :servicesCons, presence: true
  validate :date_cannot_be_in_the_past
  validate :unique_turn_for_dog, if: -> { user.client? }
  validate :must_not_be_morning_when_has_already_passed
  validates :total_amount, presence: true, on: :save_total_amount
  validates :total_amount, numericality: { greater_than: 0 }, on: :save_total_amount

  def set_user(user)
    self.user_id = user.id
  end

  def date_cannot_be_in_the_past
    if dateCons.present? && dateCons < Date.today
      errors.add(:dateCons, "la fecha presente o una futura")
    end
  end

  def unique_turn_for_dog
    existing_turns = TurnForm.where(user: user, dog: dog)
    existing_turns = existing_turns.where.not(id: id) if persisted?  # Excluye el turno actual si está siendo editado

    if existing_turns.exists?
      errors.add(:base, "Ya has solicitado un turno para este perro.")
    end
  end

  def must_not_be_morning_when_has_already_passed
    if dateCons.present? && dateCons == Date.today && Time.now > Time.parse("12:00 PM") && schedule == "morning"
      errors.add(:schedule, "'mañana' no puede ser seleccionada para hoy si ya es la tarde")
    end
  end
end