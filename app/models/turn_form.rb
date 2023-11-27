class TurnForm < ApplicationRecord
  belongs_to :user
  belongs_to :dog
  has_one :meeting, dependent: :destroy

  enum schedule: [:morning, :afternoon]

  validates :dateCons , presence: true
  validates :schedule, :servicesCons, presence: true
  validates :total_amount, presence: true, on: :save_total_amount
  validates :total_amount, numericality: { greater_than: 0 }, on: :save_total_amount
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
        errors.add( :base, "La banda horaria seleccionada es no laborable. Por favor, revisa el calendario para conocer nuestras bandas y días laborables")
      end
    end
  end

  def validate_evening_meeting
    if dateCons.present?
      eveningmeeting = Meeting.where(name: :No_laborable_en_la_tarde).where(start_time: dateCons).count
      if eveningmeeting > 0 && schedule == "afternoon"
        errors.add(:base, "La banda horaria seleccionada es no laborable. Por favor, revisa el calendario para conocer nuestras bandas y días laborables")
      end
    end
  end

  def validate_allday_meeting
    if dateCons.present?
      morningmeeting = Meeting.where(name: :No_laborable_todo_el_dia).where(start_time: dateCons).count
      if morningmeeting > 0
        errors.add(:base, "Fecha de consulta no laborable. Por favor, revisa el calendario para conocer nuestras bandas y días laborables")
      end
    end
  end

  def set_user(user)
    self.user_id = user.id
  end

  def date_cannot_be_in_the_past
    if dateCons.present? && dateCons < Date.today
      errors.add(:dateCons, "debe ser presente o futura")
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

  def date_must_be_laborable
    # Obtener todas las reuniones para la fecha seleccionada
    meetings_on_selected_date = Meeting.where(start_time: dateCons.beginning_of_day..dateCons.end_of_day)

    # Verificar si alguna reunión tiene el nombre "No_laborable_todo_el_dia"
    if meetings_on_selected_date.exists?(name: Meeting.names[:No_laborable_todo_el_dia])
      errors.add(:dateCons, "no laborable, por favor, revisa el calendario para conocer nuestras bandas horarias y días laborables.")
    end
  end

  def date_and_schedule_must_be_laborable
    # Obtener todas las reuniones para la fecha y banda horaria seleccionadas
    meetings_on_selected_date_and_schedule = Meeting.where(
      start_time: dateCons.beginning_of_day..dateCons.end_of_day,
      name: Meeting.names[meeting_schedule]
    )

    # Verificar si hay reuniones marcadas como no laborables para la fecha y banda horaria seleccionadas
    if meetings_on_selected_date_and_schedule.exists?
      errors.add(:base, "La banda horaria seleccionada es no laborable, por favor, revisa el calendario para conocer nuestras bandas horarias y días laborables.")
    end
  end

  def meeting_schedule
    case schedule
    when "morning" then :No_laborable_en_la_mañana
    when "afternoon" then :No_laborable_en_la_tarde
    else nil
    end
  end

end