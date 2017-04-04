defmodule Syndeo.Attendee do
  use Syndeo.Web, :model
  use Timex.Ecto.Timestamps

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "attendees" do
    field :name, :string
    field :street, :string
    field :city, :string
    field :state, :string
    field :zip, :string
    field :email, :string
    field :phone, :string
    field :sms, :boolean, default: false
    field :membership_status, :string
    field :age_range, :string

    has_many :weekly_info, Syndeo.WeeklyInfo, on_delete: :delete_all

    timestamps()
  end

  defp required_fields do
    [
      :name,
      :city,
      :state,
      :email,
      :membership_status,
      :age_range,
    ]
  end

  defp optional_fields do
    [
      :street,
      :sms,
      :phone,
    ]
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, required_fields() ++ optional_fields())
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/.+@.+/)
    |> validate_required(required_fields())
  end

  def membership_status do
    [
      "1st time guest",
      "2nd time guest",
      "Periodic attender",
      "Regular attender",
      "Member"
    ]
  end

  def age_ranges do
    [
      "Elementary",
      "Teen",
      "Adult"
    ]
  end

  def to_display(true), do: "Texts messages are accepted."
  def to_display(false), do: "Texts messages are not accepted."
end
