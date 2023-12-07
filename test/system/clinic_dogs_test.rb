require "application_system_test_case"

class ClinicDogsTest < ApplicationSystemTestCase
  setup do
    @clinic_dog = clinic_dogs(:one)
  end

  test "visiting the index" do
    visit clinic_dogs_url
    assert_selector "h1", text: "Clinic dogs"
  end

  test "should create clinic dog" do
    visit clinic_dogs_url
    click_on "New clinic dog"

    fill_in "Dateclinic", with: @clinic_dog.dateclinic
    fill_in "Description", with: @clinic_dog.description
    check "Question" if @clinic_dog.question
    click_on "Create Clinic dog"

    assert_text "Clinic dog was successfully created"
    click_on "Back"
  end

  test "should update Clinic dog" do
    visit clinic_dog_url(@clinic_dog)
    click_on "Edit this clinic dog", match: :first

    fill_in "Dateclinic", with: @clinic_dog.dateclinic
    fill_in "Description", with: @clinic_dog.description
    check "Question" if @clinic_dog.question
    click_on "Update Clinic dog"

    assert_text "Clinic dog was successfully updated"
    click_on "Back"
  end

  test "should destroy Clinic dog" do
    visit clinic_dog_url(@clinic_dog)
    click_on "Destroy this clinic dog", match: :first

    assert_text "Clinic dog was successfully destroyed"
  end
end
