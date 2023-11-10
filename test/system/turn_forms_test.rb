require "application_system_test_case"

class TurnFormsTest < ApplicationSystemTestCase
  setup do
    @turn_form = turn_forms(:one)
  end

  test "visiting the index" do
    visit turn_forms_url
    assert_selector "h1", text: "Turn forms"
  end

  test "should create turn form" do
    visit turn_forms_url
    click_on "New turn form"

    fill_in "Datecons", with: @turn_form.DateCons
    fill_in "Schedulecons", with: @turn_form.ScheduleCons
    fill_in "Descriptioncons", with: @turn_form.descriptionCons
    click_on "Create Turn form"

    assert_text "Turn form was successfully created"
    click_on "Back"
  end

  test "should update Turn form" do
    visit turn_form_url(@turn_form)
    click_on "Edit this turn form", match: :first

    fill_in "Datecons", with: @turn_form.DateCons
    fill_in "Schedulecons", with: @turn_form.ScheduleCons
    fill_in "Descriptioncons", with: @turn_form.descriptionCons
    click_on "Update Turn form"

    assert_text "Turn form was successfully updated"
    click_on "Back"
  end

  test "should destroy Turn form" do
    visit turn_form_url(@turn_form)
    click_on "Destroy this turn form", match: :first

    assert_text "Turn form was successfully destroyed"
  end
end
