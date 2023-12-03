require "application_system_test_case"

class WantedPostsTest < ApplicationSystemTestCase
  setup do
    @wanted_post = wanted_posts(:one)
  end

  test "visiting the index" do
    visit wanted_posts_url
    assert_selector "h1", text: "Wanted posts"
  end

  test "should create wanted post" do
    visit wanted_posts_url
    click_on "New wanted post"

    fill_in "Body", with: @wanted_post.body
    fill_in "User", with: @wanted_post.user_id
    click_on "Create Wanted post"

    assert_text "Wanted post was successfully created"
    click_on "Back"
  end

  test "should update Wanted post" do
    visit wanted_post_url(@wanted_post)
    click_on "Edit this wanted post", match: :first

    fill_in "Body", with: @wanted_post.body
    fill_in "User", with: @wanted_post.user_id
    click_on "Update Wanted post"

    assert_text "Wanted post was successfully updated"
    click_on "Back"
  end

  test "should destroy Wanted post" do
    visit wanted_post_url(@wanted_post)
    click_on "Destroy this wanted post", match: :first

    assert_text "Wanted post was successfully destroyed"
  end
end
