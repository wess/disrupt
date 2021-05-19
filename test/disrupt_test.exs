defmodule DisruptTest do
  use ExUnit.Case
  doctest Disrupt

  test "greets the world" do
    assert Disrupt.hello() == :world
  end
end
