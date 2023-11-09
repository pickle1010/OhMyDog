class TurnForm < ApplicationRecord
    has_many :services
    validates :DateCons , presence: true 
    validates :ScheduleCons , presence: true
    validates :servicesCons , presence: true   
    validate :morning_option_available

    def morning_option_available
        if :DateCons == Date.today && :ScheduleCons == 'morning'
          # Define your time range for "morning"
          morning_start_time = Time.parse('21:00:00')
          morning_end_time = Time.parse('22:00:00')

          unless (morning_start_time..morning_end_time).cover?(Time.now)
            errors.add(:ScheduleCons, 'The "Morning" option is not available outside the time range of 8:00 AM to 12:00 PM.')
          end
        end
    end

end