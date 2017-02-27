defmodule ConnectionCard.FeatureCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Hound.Helpers

      import Ecto.Schema, except: [build: 2]
      import Ecto.Query, only: [from: 2]
      import ConnectionCard.Router.Helpers
      import ConnectionCard.FeatureHelpers
      import ConnectionCard.RoleHelpers
      #    import ConnectionCard.AuthHelpers
      import ConnectionCard.Factory

      alias ConnectionCard.Repo

      @endpoint ConnectionCard.Endpoint
    end
  end

  setup tags do
    on_exit fn ->
      PhantomJS.clear_local_storage
    end

    :ok = Ecto.Adapters.SQL.Sandbox.checkout(ConnectionCard.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(ConnectionCard.Repo, {:shared, self()})
    end

    Hound.start_session
    :ok
  end
end
