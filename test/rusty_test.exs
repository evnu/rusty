defmodule RustyTest do
  use ExUnit.Case

  test "failing test" do
    assert :ok == Rusty.trampoline("test::test()")
  end

  test "working test" do
    assert :ok == Rusty.trampoline("test::test2()")
  end
end
