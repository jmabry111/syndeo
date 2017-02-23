# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :connection_card,
  ecto_repos: [ConnectionCard.Repo]

# Configures the endpoint
config :connection_card, ConnectionCard.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Oc1RDd8I//t9YQUePOF1VXghE3d+xVtDg4h8ZsLvhxsDsmq4VRvzuWKky87tMEZ1",
  render_errors: [view: ConnectionCard.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ConnectionCard.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
