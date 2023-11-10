class TurnForm < ApplicationRecord
    belongs_to :user
    has_many :services
    enum scheduleCons: [:morning, :afternoon]
    validates :dateCons , presence: true
    validates :scheduleCons , presence: true
    validates :servicesCons , presence: true
    validate :dateCons_cannot_be_in_the_past
    # validate :morning_option_available

    def set_user(user)
      self.user_id = user.id
    end

    def dateCons_cannot_be_in_the_past
      if dateCons.present? && dateCons < Date.today
        errors.add(:dateCons, "la fecha presente o una futura")
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