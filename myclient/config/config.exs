use Mix.Config

config :myclient,
  token: "abc123",
  oauth2: %{
    client_id: "clientx",
    redirect_uri: "http://localhost:4000"
  }


#     config(:myclient, key: :value)
#
# And access this configuration in your application as:
#
#     Application.get_env(:myclient, :key)
#
# Or configure a 3rd-party app:
#
#     config(:logger, level: :info)
#

# Example per-environment config:
#
#     import_config("#{Mix.env}.exs")
