# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of Mix.Config.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
use Mix.Config

# Configure Mix tasks and generators
config :megalixir,
  ecto_repos: [Megalixir.Repo]

config :megalixir_web,
  ecto_repos: [Megalixir.Repo],
  generators: [context_app: :megalixir]

# Configures the endpoint
config :megalixir_web, MegalixirWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "em6B3lGRL8eS8pga6e19Gq7lhcMPvhnzGzvQ/rsOQCFHuSn95dwAQBEPWBTKB3+8",
  render_errors: [view: MegalixirWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: MegalixirWeb.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "T5qdsNtV3ry1t/M67sENmXjtUO57ACIK"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
