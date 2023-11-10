require "test_helper"

class TurnFormsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @turn_form = turn_forms(:one)
  end

  test "should get index" do
    get turn_forms_url
    assert_response :success
  end

  test "should get new" do
    get new_turn_form_url
    assert_response :success
  end

  test "should create turn_form" do
    assert_difference("TurnForm.count") do
      post turn_forms_url, params: { turn_form: { DateCons: @turn_form.DateCons, ScheduleCons: @turn_form.ScheduleCons, descriptionCons: @turn_form.descriptionCons } }
    end

    assert_redirected_to turn_form_url(TurnForm.last)
  end

  test "should show turn_form" do
    get turn_form_url(@turn_form)
    assert_response :success
  end

  test "should get edit" do
    get edit_turn_form_url(@turn_form)
    assert_response :success
  end

  test "should update turn_form" do
    patch turn_form_url(@turn_form), params: { turn_form: { DateCons: @turn_form.DateCons, ScheduleCons: @turn_form.ScheduleCons, descriptionCons: @turn_form.descriptionCons } }
    assert_redirected_to turn_form_url(@turn_form)
  end

  test "should destroy turn_form" do
    assert_difference("TurnForm.count", -1) do
      delete turn_form_url(@turn_form)
    end

    assert_redirected_to turn_forms_url
  end
end
