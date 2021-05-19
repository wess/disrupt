#
# player.ex
# Disrupt
#
# Author: Wess Cope (me@wess.io)
# Created: 05/19/2021
#
# Copywrite (c) 2021 Wess.io
#

defmodule Server.Client do
  require Logger

  alias Server.Protocol

  def start_link(protocol) do
    GenServer.start_link(__MODULE__, protocol)
  end

  def read(pid, message) do
    GenServer.cast(pid, {:read, message})
  end

  def write(pid, message) do
    GenServer.cast(pid, {:write, message})
  end

  def quit(pid) do
    GenServer.cast(pid, :quit)
  end

  ## Callbacks
  def init(protocol) do
    send(self(), :welcome)
    {:ok, %{protocol: protocol}}
  end

  def handle_cast({:read, message}, %{protocol: protocol} = state) do
    Logger.info(fn-> "PROTO: #{inspect(protocol)} // reading: #{message}" end)
    if message == "q" do
      Protocol.disconnect(protocol)

      {:stop, :normal, state}
    else
      {:noreply, state}
    end
  end

  def handle_cast({:write, message}, state) do
    Logger.info(fn-> "Writing: #{message}" end)

    {:noreply, state}
  end

  def handle_cast(:quit, state) do
    Logger.info(fn-> "Quitting.." end)

    {:stop, :normal, state}
  end

  def handle_info(:welcome, %{protocol: _protocol} = state) do
    UI.Main.start()

    {:noreply, state}
  end
end
