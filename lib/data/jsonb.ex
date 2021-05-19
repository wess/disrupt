#
# jsonb.ex
# Disrupt
#
# Author: Wess Cope (me@wess.io)
# Created: 05/19/2021
#
# Copywrite (c) 2021 Wess.io
#

defmodule Jsonb do
  import Ecto.Query

  defmacro query(qry, col, params, opts) do
    where_clause = Keyword.get(opts, :where_type, :where)

    quote do
      Enum.reduce(
        unquote(params),
        unquote(qry),
        fn {k,v}, acc ->
          from(q in acc, [
            {
              unquote(where_clause),
              fragment(
                "?::jsonb @> ?::jsonb",
                field(q, ^unquote(col)),
                ^%{to_string(key) => val}
              )
            }
          ])
        end
      )
    end
  end
end
