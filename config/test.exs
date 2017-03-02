use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :connection_card, ConnectionCard.Endpoint,
  http: [port: 4001],
  server: true

# Print only warnings and errors during test
config :logger, :console, format: "[$level] $message\n"
# config :logger, level: :warn

# Configure your database
config :connection_card, ConnectionCard.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "connection_card_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :hound, driver: "phantomjs", port: 8910

config :connection_card, ConnectionCard.Mailer, adapter: Bamboo.TestAdapter
