defmodule RustyTest do
  use ExUnit.Case
  doctest Rusty

  test "greets the world" do
    assert Rusty.hello() == :world
  end
end
