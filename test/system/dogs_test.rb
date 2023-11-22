require "application_system_test_case"

class DogsTest < ApplicationSystemTestCase
  setup do
    @dog = dogs(:one)
  end

  test "visiting the index" do
    visit dogs_url
    assert_selector "h1", text: "Dogs"
  end

  test "should create dog" do
    visit dogs_url
    click_on "New dog"

    fill_in "Birthday", with: @dog.birthday
    fill_in "Breed", with: @dog.breed
    fill_in "Color", with: @dog.color
    fill_in "First name", with: @dog.first_name
    fill_in "Last name", with: @dog.last_name
    fill_in "Sex", with: @dog.sex
    fill_in "User", with: @dog.user_id
    click_on "Create Dog"

    assert_text "Dog was successfully created"
    click_on "Back"
  end

  test "should update Dog" do
    visit dog_url(@dog)
    click_on "Edit this dog", match: :first

    fill_in "Birthday", with: @dog.birthday
    fill_in "Breed", with: @dog.breed
    fill_in "Color", with: @dog.color
    fill_in "First name", with: @dog.first_name
    fill_in "Last name", with: @dog.last_name
    fill_in "Sex", with: @dog.sex
    fill_in "User", with: @dog.user_id
    click_on "Update Dog"

    assert_text "Dog was successfully updated"
    click_on "Back"
  end

  test "should destroy Dog" do
    visit dog_url(@dog)
    click_on "Destroy this dog", match: :first

    assert_text "Dog was successfully destroyed"
  end
end
