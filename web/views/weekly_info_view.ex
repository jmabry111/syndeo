defmodule Syndeo.WeeklyInfoView do
  use Syndeo.Web, :view

  def to_display(true), do: "Yes"
  def to_display(false), do: "No"
end
