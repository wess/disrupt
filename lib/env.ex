#
# env.ex
# Disrupt
#
# Author: Wess Cope (me@wess.io)
# Created: 05/19/2021
#
# Copywrite (c) 2021 Wess.io
#

defmodule Env do
  def static_dir do
    Path.join(
      Application.app_dir(
        :disrupt,
        "priv"
      ),
      "static"
    )
  end
end
