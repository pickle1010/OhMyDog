class ClinicDog < ApplicationRecord
    enum vaccines: [:antirrabica, :inmunologica, :ambas]
    validates :description, presence: true
    validates :question, inclusion: { in: [true, false] }
  
    with_options if: :question? do |clinic_dog|
      clinic_dog.validates :dateclinic, presence: true
      clinic_dog.validates :vaccines, presence: true
    end
end