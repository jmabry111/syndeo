defmodule ConnectionCard.Attendee do
  use ConnectionCard.Web, :model

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
end
