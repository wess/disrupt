#
# repo.ex
# Disrupt
#
# Author: Wess Cope (me@wess.io)
# Created: 05/19/2021
#
# Copywrite (c) 2021 Wess.io
#

defmodule Data.Repo do
  use Ecto.Repo,
      otp_app: :disrupt,
      adapter: Ecto.Adapters.Postgres
end
