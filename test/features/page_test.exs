defmodule ConnectionCard.Feature.PageTest do
  use Wilbur.FeatureCase

  test "homepage works" do
    navigate to "/"
    assert String.contains?(visible_page_text, "Welcome to Phoenix")
  end
end
