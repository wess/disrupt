#
# .iex.exs
# ancilla
#
# Author: Wess Cope (you@you.you)
# Created: 05/13/2021
#
# Copywrite (c) 2021 Wess.io
#

defmodule R do
  def reload! do
    Mix.Task.reenable "compile.elixir"
    Application.stop(Mix.Project.config[:app])
    Mix.Task.run "compile.elixir"
    Application.start(Mix.Project.config[:app], :permanent)
  end
end
