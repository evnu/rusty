defmodule RustyTest do
  use ExUnit.Case
  use PropCheck

  property "echo term" do
    numtests(
      1000,
      forall t <- term() do
        result = Rusty.echo_term(t)
        when_fail(
          t == result,
          IO.inspect([expected: t, received: result])
        )
      end
      )
  end
end
