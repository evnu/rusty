defmodule CargoTestRunnerTest do
  use ExUnit.Case

  # TODO due to recompilation within the NIF, this might take a while
  @tag timeout: (10 * 60 * 1_000)
  test "all" do
    assert :ok == CargoTestRunner.run_tests()
  end
end
