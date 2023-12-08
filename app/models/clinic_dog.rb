class ClinicDog < ApplicationRecord
    belongs_to :dog
    has_one :meeting, dependent: :destroy
    has_one :message, dependent: :destroy

    validates :description, :dateclinic, presence: true
    validate :date_cannot_be_in_the_future
    validate :rabies_info_must_be_completed_or_blank
    validate :inmunological_info_must_be_completed_or_blank
    validates :rabies_dosage, numericality: { greater_than: 0 }, if: -> { rabies_dosage.present? }
    validates :rabies_dosage, format: { with: /\A\d+(\.\d{1,2})?\z/, message: "debe ser un numero con máximo 2 cifras decimales" }, if: -> { rabies_dosage.present? }
    validates :inmunological_dosage, numericality: { greater_than: 0 }, if: -> { inmunological_dosage.present? }
    validates :inmunological_dosage, format: { with: /\A\d+(\.\d{1,2})?\z/, message: "debe ser un numero con máximo 2 cifras decimales" }, if: -> { inmunological_dosage.present? }

    def date_cannot_be_in_the_future
      if dateclinic.present? && dateclinic > Date.today
        errors.add(:dateclinic, "debe ser previa o actual")
      end
    end

    def rabies_info_must_be_completed_or_blank
      if !rabies_dosage.present? && rabies_batch.present?
        errors.add(:rabies_dosage, "no ha sido indicada. Si no fue aplicada esta vacuna, deje los campos de la misma en blanco")
      elsif rabies_dosage.present? && !rabies_batch.present?
        errors.add(:rabies_batch, "no ha sido indicado. Si no fue aplicada esta vacuna, deje los campos de la misma en blanco")
      end
    end

    def inmunological_info_must_be_completed_or_blank
      if !inmunological_dosage.present? && inmunological_batch.present?
        errors.add(:inmunological_dosage, "no ha sido indicada. Si no fue aplicada esta vacuna, deje los campos de la misma en blanco")
      elsif inmunological_dosage.present? && !inmunological_batch.present?
        errors.add(:inmunological_batch, "no ha sido indicado. Si no fue aplicada esta vacuna, deje los campos de la misma en blanco")
      end
    end

    def rabies_applied
      rabies_dosage.present? && rabies_batch.present?
    end

    def inmunological_applied
      inmunological_dosage.present? && inmunological_batch.present?
    end
end