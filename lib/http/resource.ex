#
# resource.ex
# Disrupt
#
# Author: Wess Cope (me@wess.io)
# Created: 05/19/2021
#
# Copywrite (c) 2021 Wess.io
#

defmodule Http.Resource do
  defmacro __using__(_) do
    quote do
      require Logger
      import Plug.Conn

      use Plug.Router
      use Http.Response

      import unquote(__MODULE__)

      plug Plug.Parsers,
      parsers: [:urlencoded, :multipart, :json],
      pass: ["*/*"],
      json_decoder: Jason
    end
  end
end
