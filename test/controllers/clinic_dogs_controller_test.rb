require "test_helper"

class ClinicDogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @clinic_dog = clinic_dogs(:one)
  end

  test "should get index" do
    get clinic_dogs_url
    assert_response :success
  end

  test "should get new" do
    get new_clinic_dog_url
    assert_response :success
  end

  test "should create clinic_dog" do
    assert_difference("ClinicDog.count") do
      post clinic_dogs_url, params: { clinic_dog: { dateclinic: @clinic_dog.dateclinic, description: @clinic_dog.description, question: @clinic_dog.question } }
    end

    assert_redirected_to clinic_dog_url(ClinicDog.last)
  end

  test "should show clinic_dog" do
    get clinic_dog_url(@clinic_dog)
    assert_response :success
  end

  test "should get edit" do
    get edit_clinic_dog_url(@clinic_dog)
    assert_response :success
  end

  test "should update clinic_dog" do
    patch clinic_dog_url(@clinic_dog), params: { clinic_dog: { dateclinic: @clinic_dog.dateclinic, description: @clinic_dog.description, question: @clinic_dog.question } }
    assert_redirected_to clinic_dog_url(@clinic_dog)
  end

  test "should destroy clinic_dog" do
    assert_difference("ClinicDog.count", -1) do
      delete clinic_dog_url(@clinic_dog)
    end

    assert_redirected_to clinic_dogs_url
  end
end
