defmodule Syndeo.User do
  use Syndeo.Web, :model
  import Doorman.Auth.Bcrypt, only: [hash_password: 1]

  schema "users" do
    field :name, :string
    field :email, :string
    field :hashed_password, :string
    field :password, :string, virtual: true

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email, :password])
    |> validate_required([:name, :email, :password])
    |> hash_password
    |> unique_constraint(:email)
  end
end
