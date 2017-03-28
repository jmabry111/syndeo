defmodule Syndeo.FeatureCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Hound.Helpers

      import Ecto.Schema, except: [build: 2]
      import Ecto.Query, only: [from: 2]
      import Syndeo.Router.Helpers
      import Syndeo.FeatureHelpers
      import Syndeo.RoleHelpers
      import Syndeo.AuthHelpers
      import Syndeo.Factory

      alias Syndeo.Repo

      @endpoint Syndeo.Endpoint
    end
  end

  setup tags do
    on_exit fn ->
      PhantomJS.clear_local_storage
    end

    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Syndeo.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Syndeo.Repo, {:shared, self()})
    end

    Hound.start_session
    :ok
  end
end
