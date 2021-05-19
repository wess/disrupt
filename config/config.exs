#
# config.exs
# Disrupt
#
# Author: Wess Cope (me@wess.io)
# Created: 05/19/2021
#
# Copywrite (c) 2021 Wess.io
#

import Config

config :disrupt, ecto_repos: [Data.Repo]

config :disrupt, Data.Repo,
  database: System.get_env("DB_NAME"),
  username: System.get_env("DB_USERNAME"),
  password: System.get_env("DB_PASSWORD"),
  hostname: System.get_env("DB_HOST"),
  port: System.get_env("DB_PORT")
