class ClinicDog < ApplicationRecord
    belongs_to :dog
    has_one :meeting, dependent: :destroy

    enum vaccines: [:antirrabica, :inmunologica, :ambas]

    validates :description, :dateclinic, presence: true
    validates :question, presence: true, if: :vaccines_present?
    validates :question, inclusion: { in: [true, false] }
    validate :date_cannot_be_in_the_future

    with_options if: :question? do |clinic_dog|
      clinic_dog.validates :vaccines, presence: true
    end

    def vaccines_present?
      vaccines.present?
    end

    def date_cannot_be_in_the_future
      if dateclinic.present? && dateclinic > Date.today
        errors.add(:dateclinic, "debe ser previa o actual")
      end
    end
end