#
# protocol.ex
# Disrupt
#
# Author: Wess Cope (me@wess.io)
# Created: 05/19/2021
#
# Copywrite (c) 2021 Wess.io
#

defmodule Server.Protocol do
  require Logger
  use GenServer

  alias Server.Client

  @behaviour :ranch_protocol

  def start_link(ref, transport, _opts) do
    pid = :proc_lib.spawn_link(__MODULE__, :init, [ref, transport])

    {:ok, pid}
  end

  def init(ref, transport) do
    {:ok, socket} = :ranch.handshake(ref)
    :ok = transport.setopts(socket, [{:active, true}])

    {:ok, {ip, _port}} = :inet.peername(socket)
    ip = :inet.ntoa(ip)

    {:ok, client} = Client.start_link(self())

    Logger.info(fn-> "[#{ip}] connected." end)

    :gen_server.enter_loop(
      __MODULE__, [], %{
        ip: ip,
        client: client,
        transport: transport,
        socket: socket,
      }
    )
  end

  def ip(pid) do
    GenServer.call(pid, :ip)
  end

  def write(pid, message) do
    GenServer.cast(pid, {:send, message})
  end

  def disconnect(pid) do
    GenServer.cast(pid, :disconnect)
  end

  ## Callbacks
  def init(_opts), do: {:stop, nil}

  def handle_call(:ip, _from, %{ip: ip} = state) do
    {:reply, ip, state}
  end

  def handle_cast({:send, message}, %{transport: transport, socket: socket} = state) do
    transport.send(socket, message)

    {:noreply, state}
  end

  def handle_cast(:disconnect, %{transport: transport, socket: socket} = state) do
    transport.close(socket)

    {:stop, :normal, state}
  end

  def handle_info({:tcp, _socket, data}, %{client: client} = state) do
    Client.read(client, String.trim(data))

    {:noreply, state}
  end

  def handle_info({:tcp_closed, socket}, %{ip: ip, transport: transport} = state) do
    Logger.info(fn-> "[#{ip}] disconnected." end)

    transport.close(socket)

    {:stop, :normal, state}
  end
end
