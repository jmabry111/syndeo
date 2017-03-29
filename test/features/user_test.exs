defmodule Syndeo.Feature.UserTest do
  use Syndeo.FeatureCase
  alias Syndeo.User

  test "create a user and it shows" do
    user = build(:user) |> save
    sign_in_and_visit "/admin/users", user
    click_on "New user"

    fill_in "user", "email", with: "me@example.com"
    fill_in "user", "password", with: "password"
    submit()

    navigate_to "/admin/users"
    assert text_for_role("user") =~ "me@example.com"
  end

  test "update existing user" do
    user = build(:user, email: "mabry@example.com") |> save
    sign_in_and_visit "/admin/users", user
    click_on "Edit"

    fill_in "user", "email", with: "jason@example.com"
    fill_in "user", "password", with: "password"
    submit()

    navigate_to "/admin/users"
    assert text_for_role("user") =~ "jason@example.com"
  end

  test "delete user" do
    user = build(:user) |> save

    sign_in_and_visit "/admin/users", user

    click_on "Delete"

    refute visible_page_text() =~ user.email
    refute Repo.get(User, user.id)
  end
end
