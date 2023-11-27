class Meeting < ApplicationRecord
    belongs_to :turn_form, optional: true
    belongs_to :clinic_dog, optional: true
    belongs_to :user, optional: true
    belongs_to :dog, optional: true

    enum name: [:No_laborable_todo_el_dia, :No_laborable_en_la_mañana, :No_laborable_en_la_tarde, :Vacunacion, :Turno]
    
    validates :name, presence: true, uniqueness: false
    validates :start_time, presence: true

    validate :start_time_cannot_be_in_the_past

    private
  
    def start_time_cannot_be_in_the_past
      errors.add(:start_time, "debe ser actual o futura") if start_time.present? && start_time < Date.today
    end

end
