require "test_helper"

class AdoptionPostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @adoption_post = adoption_posts(:one)
  end

  test "should get index" do
    get adoption_posts_url
    assert_response :success
  end

  test "should get new" do
    get new_adoption_post_url
    assert_response :success
  end

  test "should create adoption_post" do
    assert_difference("AdoptionPost.count") do
      post adoption_posts_url, params: { adoption_post: { body: @adoption_post.body, user_id: @adoption_post.user_id } }
    end

    assert_redirected_to adoption_post_url(AdoptionPost.last)
  end

  test "should show adoption_post" do
    get adoption_post_url(@adoption_post)
    assert_response :success
  end

  test "should get edit" do
    get edit_adoption_post_url(@adoption_post)
    assert_response :success
  end

  test "should update adoption_post" do
    patch adoption_post_url(@adoption_post), params: { adoption_post: { body: @adoption_post.body, user_id: @adoption_post.user_id } }
    assert_redirected_to adoption_post_url(@adoption_post)
  end

  test "should destroy adoption_post" do
    assert_difference("AdoptionPost.count", -1) do
      delete adoption_post_url(@adoption_post)
    end

    assert_redirected_to adoption_posts_url
  end
end
