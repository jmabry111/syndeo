defmodule Syndeo.AttendeeView do
  use Syndeo.Web, :view

  def display_sms_availability(true), do: "Texts messages are accepted."
  def display_sms_availability(false), do: "Texts messages are not accepted."
end
