require "application_system_test_case"

class DogWalkersTest < ApplicationSystemTestCase
  setup do
    @dog_walker = dog_walkers(:one)
  end

  test "visiting the index" do
    visit dog_walkers_url
    assert_selector "h1", text: "Dog walkers"
  end

  test "should create dog walker" do
    visit dog_walkers_url
    click_on "New dog walker"

    fill_in "Contact", with: @dog_walker.contact
    fill_in "Lastname", with: @dog_walker.lastname
    fill_in "Name", with: @dog_walker.name
    fill_in "Service", with: @dog_walker.service
    fill_in "Workplace", with: @dog_walker.workplace
    click_on "Create Dog walker"

    assert_text "Dog walker was successfully created"
    click_on "Back"
  end

  test "should update Dog walker" do
    visit dog_walker_url(@dog_walker)
    click_on "Edit this dog walker", match: :first

    fill_in "Contact", with: @dog_walker.contact
    fill_in "Lastname", with: @dog_walker.lastname
    fill_in "Name", with: @dog_walker.name
    fill_in "Service", with: @dog_walker.service
    fill_in "Workplace", with: @dog_walker.workplace
    click_on "Update Dog walker"

    assert_text "Dog walker was successfully updated"
    click_on "Back"
  end

  test "should destroy Dog walker" do
    visit dog_walker_url(@dog_walker)
    click_on "Destroy this dog walker", match: :first

    assert_text "Dog walker was successfully destroyed"
  end
end
