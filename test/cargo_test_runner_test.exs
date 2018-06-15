defmodule CargoTestRunnerTest do
  use ExUnit.Case

  test "all" do
    assert :ok == CargoTestRunner.run_tests()
  end
end
