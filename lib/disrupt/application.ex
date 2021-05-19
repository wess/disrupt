#
# application.ex
# Disrupt
#
# Author: Wess Cope (me@wess.io)
# Created: 05/19/2021
#
# Copywrite (c) 2021 Wess.io
#


defmodule Disrupt.Application do
  require Logger
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {
        Plug.Cowboy,
        scheme: :http,
        plug: Disrupt.Router,
        options: [
          port: port()
        ]
      },
      {
        Server.Listener,
        [5000]
      }
    ]

    Logger.info(fn-> "Starting services..." end)

    opts = [strategy: :one_for_one, name: Disrupt.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp port do
    System.get_env("HTTP_PORT", "3000")
    |> String.to_integer()
  end
end
