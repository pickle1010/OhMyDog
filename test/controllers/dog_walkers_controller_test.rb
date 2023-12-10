require "test_helper"

class DogWalkersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dog_walker = dog_walkers(:one)
  end

  test "should get index" do
    get dog_walkers_url
    assert_response :success
  end

  test "should get new" do
    get new_dog_walker_url
    assert_response :success
  end

  test "should create dog_walker" do
    assert_difference("DogWalker.count") do
      post dog_walkers_url, params: { dog_walker: { contact: @dog_walker.contact, lastname: @dog_walker.lastname, name: @dog_walker.name, service: @dog_walker.service, workplace: @dog_walker.workplace } }
    end

    assert_redirected_to dog_walker_url(DogWalker.last)
  end

  test "should show dog_walker" do
    get dog_walker_url(@dog_walker)
    assert_response :success
  end

  test "should get edit" do
    get edit_dog_walker_url(@dog_walker)
    assert_response :success
  end

  test "should update dog_walker" do
    patch dog_walker_url(@dog_walker), params: { dog_walker: { contact: @dog_walker.contact, lastname: @dog_walker.lastname, name: @dog_walker.name, service: @dog_walker.service, workplace: @dog_walker.workplace } }
    assert_redirected_to dog_walker_url(@dog_walker)
  end

  test "should destroy dog_walker" do
    assert_difference("DogWalker.count", -1) do
      delete dog_walker_url(@dog_walker)
    end

    assert_redirected_to dog_walkers_url
  end
end
