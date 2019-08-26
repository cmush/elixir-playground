defmodule Myclient.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Myclient.Oauth2, []),
    ]

    opts = [
      strategy: :one_for_one,
      name: Myclient.Supervisor
    ]

    Supervisor.start_link(children, opts)
  end
end
