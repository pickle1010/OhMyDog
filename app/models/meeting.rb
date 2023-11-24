class Meeting < ApplicationRecord
    belongs_to :turn_form, optional: true
    belongs_to :user, optional: true
    enum name: [:No_laborable_todo_el_dia, :No_laborable_en_la_mañana, :No_laborable_en_la_tarde, :Vacunacion, :Turno]
    validates :name, presence: true, uniqueness: false
    validates :start_time, presence: true
end
