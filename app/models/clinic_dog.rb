class ClinicDog < ApplicationRecord
    belongs_to :dog
    has_one :meeting, dependent: :destroy
    has_one :message, dependent: :destroy

    enum vaccines: [:ninguna, :antirrabica, :inmunologica, :ambas]

    validates :description, :dateclinic, presence: true
    validate :date_cannot_be_in_the_future

    def date_cannot_be_in_the_future
      if dateclinic.present? && dateclinic > Date.today
        errors.add(:dateclinic, "debe ser previa o actual")
      end
    end
end