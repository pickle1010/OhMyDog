require "test_helper"

class WantedPostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wanted_post = wanted_posts(:one)
  end

  test "should get index" do
    get wanted_posts_url
    assert_response :success
  end

  test "should get new" do
    get new_wanted_post_url
    assert_response :success
  end

  test "should create wanted_post" do
    assert_difference("WantedPost.count") do
      post wanted_posts_url, params: { wanted_post: { body: @wanted_post.body, user_id: @wanted_post.user_id } }
    end

    assert_redirected_to wanted_post_url(WantedPost.last)
  end

  test "should show wanted_post" do
    get wanted_post_url(@wanted_post)
    assert_response :success
  end

  test "should get edit" do
    get edit_wanted_post_url(@wanted_post)
    assert_response :success
  end

  test "should update wanted_post" do
    patch wanted_post_url(@wanted_post), params: { wanted_post: { body: @wanted_post.body, user_id: @wanted_post.user_id } }
    assert_redirected_to wanted_post_url(@wanted_post)
  end

  test "should destroy wanted_post" do
    assert_difference("WantedPost.count", -1) do
      delete wanted_post_url(@wanted_post)
    end

    assert_redirected_to wanted_posts_url
  end
end
