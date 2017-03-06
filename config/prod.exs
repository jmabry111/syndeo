use Mix.Config

config :syndeo, Syndeo.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [scheme: "https", host: System.get_env("HOST"), port: 443],
  force_ssl: [rewrite_on: [:x_forwarded_proto]],
  cache_static_manifest: "priv/static/manifest.json",
  secret_key_base: System.get_env("SECRET_KEY_BASE")

config :logger, level: :info

config :syndeo, Syndeo.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
  ssl: true

config :syndeo, Syndeo.Mailer,
#  adapter: Bamboo.MailgunAdapter,
#  domain: System.get_env("MAILGUN_DOMAIN"),
#  api_key: System.get_env("MAILGUN_API_KEY")
  adapter: Bamboo.SMTPAdapter,
  server: "smtp.mailgun.org",
  username: System.get_env("SMTP_USER"),
  password: System.get_env("SMTP_PASS")

