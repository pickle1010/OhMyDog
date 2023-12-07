class ChangeQuestionTypeInClinicDog < ActiveRecord::Migration[7.1]
  def change
    add_column :clinic_dogs, :vaccines, :integer
  end
end
