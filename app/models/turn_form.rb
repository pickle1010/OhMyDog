class TurnForm < ApplicationRecord
  belongs_to :user
  belongs_to :dog

  enum schedule: [:morning, :afternoon]

  validates :dateCons , presence: true
  validates :schedule, :servicesCons, presence: true
  validate :date_cannot_be_in_the_past
  validate :unique_turn_for_dog, if: -> { user.client? }
  validate :must_not_be_morning_when_has_already_passed
  validate :validate_morning_meeting, if: -> { user.client?} 
  validate :validate_evening_meeting, if: -> { user.client?}
  validate :validate_allday_meeting, if: -> { user.client?}

  def validate_morning_meeting
    if dateCons.present?
      morningmeeting = Meeting.where(name: :No_laborable_en_la_mañana).where(start_time: dateCons).count
      if morningmeeting > 0 && schedule == "morning"
        errors.add( :base, "La franja horaria elegida de ese dia no esta disponible.")
      end
    end
  end

  def validate_evening_meeting
    if dateCons.present?
      eveningmeeting = Meeting.where(name: :No_laborable_en_la_tarde).where(start_time: dateCons).count
      if eveningmeeting > 0 && schedule == "afternoon"
        errors.add(:base, "La franja horaria de la tarde no esta disponible ese dia")
      end
    end
  end

  def validate_allday_meeting
    if dateCons.present?
      morningmeeting = Meeting.where(name: :No_laborable_todo_el_dia).where(start_time: dateCons).count
      if morningmeeting > 0
        errors.add(:base, "Ese dia no es laborable")
      end
    end
  end

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