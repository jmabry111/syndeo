defmodule Syndeo.AuthHelpers do
  use Hound.Helpers

  def sign_in(user) do
    navigate_to "/admin/users?as=#{user.id}"
  end

  def sign_in_and_visit(path, user) do
    sign_in(user)
    navigate_to path
  end
end
