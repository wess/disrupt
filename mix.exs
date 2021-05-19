#
# mix.exs
# Disrupt
#
# Author: Wess Cope (me@wess.io)
# Created: 05/19/2021
#
# Copywrite (c) 2021 Wess.io
#

defmodule Disrupt.MixProject do
  use Mix.Project

  @version File.read!('VERSION') |> String.trim()

  def project do
    [
      app: :disrupt,
      version: @version,
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Disrupt.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:elixir_uuid, "~> 1.2"},
      {:jason, "~> 1.2.2"},
      {:mimerl, "~> 1.2.0"},
      {:plug_cowboy, "~> 2.5.0"},
      {:ecto_sql, "~> 3.6"},
      {:postgrex, "~> 0.15"},
      {:ratatouille, "~> 0.5.1"},
      {:ranch, "~> 2.0", override: true}
    ]
  end
end
