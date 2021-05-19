#
# router.ex
# Disrupt
#
# Author: Wess Cope (me@wess.io)
# Created: 05/19/2021
#
# Copywrite (c) 2021 Wess.io
#

defmodule Disrupt.Router do
  use Http.Resource

  plug Plug.Static, at: "/static", from: :disrupt

  plug :match
  plug :dispatch

  get "/" do
    conn
    |> static(200, 'index.html')
  end

  match _ do
    conn
    |> json(404, %{error: 'not found'})
  end
end
