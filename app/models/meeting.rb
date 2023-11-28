class Meeting < ApplicationRecord
    belongs_to :turn_form, optional: true
    belongs_to :clinic_dog, optional: true
    belongs_to :user, optional: true
    belongs_to :dog, optional: true

    enum name: [:No_laborable_todo_el_dia, :No_laborable_en_la_mañana, :No_laborable_en_la_tarde, :Vacunacion, :Turno]
    
    validates :name, presence: true, uniqueness: false
    validates :start_time, presence: true
    validate :date_cannot_be_in_the_past
    validate :date_can_only_have_one_non_business_schedule, on: :create

    def date_cannot_be_in_the_past
      non_business_schedules = ["No_laborable_en_la_mañana", "No_laborable_en_la_tarde", "No_laborable_todo_el_dia"]
      if start_time.present? && start_time < Date.today && non_business_schedules.include?(name)
        errors.add(:start_time, "debe ser presente o futura")
      end
    end

    def date_can_only_have_one_non_business_schedule
      non_business_schedules = ["No_laborable_en_la_mañana", "No_laborable_en_la_tarde", "No_laborable_todo_el_dia"]
      if start_time.present? && non_business_schedules.include?(name)
        non_business_meetings = Meeting.where(start_time: start_time).where(name: non_business_schedules).count
        if non_business_meetings > 0
          errors.add(:base, "Ya se indicó para esta fecha que no se trabajará en el día o en alguna banda horaria. Modifique el evento existente si desea cambiar algo")
        end
      end
    end
end
