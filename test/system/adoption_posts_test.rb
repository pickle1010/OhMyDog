require "application_system_test_case"

class AdoptionPostsTest < ApplicationSystemTestCase
  setup do
    @adoption_post = adoption_posts(:one)
  end

  test "visiting the index" do
    visit adoption_posts_url
    assert_selector "h1", text: "Adoption posts"
  end

  test "should create adoption post" do
    visit adoption_posts_url
    click_on "New adoption post"

    fill_in "Body", with: @adoption_post.body
    fill_in "User", with: @adoption_post.user_id
    click_on "Create Adoption post"

    assert_text "Adoption post was successfully created"
    click_on "Back"
  end

  test "should update Adoption post" do
    visit adoption_post_url(@adoption_post)
    click_on "Edit this adoption post", match: :first

    fill_in "Body", with: @adoption_post.body
    fill_in "User", with: @adoption_post.user_id
    click_on "Update Adoption post"

    assert_text "Adoption post was successfully updated"
    click_on "Back"
  end

  test "should destroy Adoption post" do
    visit adoption_post_url(@adoption_post)
    click_on "Destroy this adoption post", match: :first

    assert_text "Adoption post was successfully destroyed"
  end
end
