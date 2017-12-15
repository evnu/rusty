defmodule RustyTest do
  use ExUnit.Case
  use PropCheck

  @tag timeout: 60_000
  property "echo term" do
    numtests(
      1000_000,
      forall t <- term() do
        File.write!("/tmp/data", :erlang.term_to_binary(t))
        result = Rusty.echo_term(t)
        when_fail(
          t == result,
          IO.inspect([expected: t, received: result])
        )
      end
      )
  end

  test "failed input 1" do
    # found with 'echo term' property, but does not fail on its own
    r = <<231, 0::size(2)>>
    assert r == Rusty.echo_term(r)
  end

  test "failed input 2" do
    # found with 'echo term' property, but does not fail on its own
    r = :""
    assert r == Rusty.echo_term(r)
  end
end
