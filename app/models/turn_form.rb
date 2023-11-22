class TurnForm < ApplicationRecord
    belongs_to :user
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

    # def morning_option_available
    #   # Check if the :date is today, and the :schedule is set to "morning" when it's already afternoon
    #   # if dateCons.present? && scheduleCons == "morning" && afternoon_for_today?
    #   #   errors.add(:scheduleCons, "cannot be morning for today as it's already afternoon.")
    #   # end
    #   # if scheduleCons == "morning" && dateCons == Date.current && Time.current >= Time.zone.parse("03:40 AM")
    #   #   errors.add(:scheduleCons, "You cannot choose 'morning' for today if it's already afternoon.")
    #   # end
    #   if Time.now >= Time.zone.parse("04:00 AM")
    #     errors.add(:scheduleCons, "You cannot choose 'morning' for today if it's already afternoon.")
    #   end
    # end
  
    # def afternoon_for_today?
    #   # Compare the current time with the afternoon threshold
    #   Time.current >= Time.parse('00:02:00')
    # end
  
    # def afternoon_threshold
    #   # Set the threshold time for considering it as afternoon (e.g., 12:00 PM)
    #   Time.current.midday
    # end
end