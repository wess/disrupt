#
# listener.ex
# Disrupt
#
# Author: Wess Cope (me@wess.io)
# Created: 05/19/2021
#
# Copywrite (c) 2021 Wess.io
#

defmodule Server.Listener do
  require Logger

  def start_link(port) do
    Logger.info(fn-> "Disrupt server starting on port #{port}" end)

    :ranch.start_listener(
      __MODULE__,
      :ranch_tcp,
      [{:port, port}],
      Server.Protocol,
      []
    )
  end

  def child_spec(args) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, args}
    }
  end
end
