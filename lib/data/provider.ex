#
# provider.ex
# Disrupt
#
# Author: Wess Cope (me@wess.io)
# Created: 05/19/2021
#
# Copywrite (c) 2021 Wess.io
#

defmodule Data.Provider do
  defmacro __using__(_) do
    quote do
      import Ecto.Query
    end
  end
end
