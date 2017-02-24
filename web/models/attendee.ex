defmodule ConnectionCard.Attendee do
  use ConnectionCard.Web, :model
  use Timex.Ecto.Timestamps

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "attendees" do
    field :service, :string
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

    has_many :weekly_info, ConnectionCard.WeeklyInfo, on_delete: :delete_all

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:service, :name, :street, :city, :state, :zip, :email, :phone, :sms, :membership_status, :age_range])
    |> validate_required([:service, :name, :street, :city, :state, :zip, :email, :phone, :sms, :membership_status, :age_range])
  end

  def services do
    [
      "9:00",
      "10:30"
    ]
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
end
