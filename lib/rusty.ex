defmodule ARecord do
  import Record
  defrecord :arecord, [a: 10, b: 1.0, c: "hello", d: self()]
end

defmodule WrappingRecord do
  import Record
  import ARecord
  defrecord :wrappingrecord, [a: arecord(), b: 10]
end

defmodule Rusty do
  use Rustler, otp_app: :rusty, crate: "rusty"

  defmodule AStruct do
    defstruct [a: 10, b: 1.0, c: "hello", d: self()]
  end

  defmodule WrappingStruct do
    defstruct [a: %Rusty.AStruct{}, b: 10]
  end

  defmodule ATuple do
    def new do
      {10, 1.0, "hello", d: self()}
    end
  end

  defmodule WrappingTuple do
    def new do
      {Rusty.ATuple.new(), 10}
    end
  end

  def bench do
    s = %Rusty.AStruct{}
    ws = %Rusty.WrappingStruct{}
    t = Rusty.ATuple.new()
    wt = Rusty.WrappingTuple.new()
    import ARecord
    import WrappingRecord
    r = arecord()
    wr = wrappingrecord()

    Benchee.run(%{
      "echo struct" => fn -> echo_struct(s) end,
      "echo wrapping struct" => fn -> echo_wrapping_struct(ws) end,
      "echo tuple" => fn -> echo_tuple(t) end,
      "echo wrapping tuple" => fn -> echo_wrapping_tuple(wt) end,
      "echo record" => fn -> echo_record(r) end,
      "echo wrapping record" => fn -> echo_wrapping_record(wr) end,
    })
  end

  def test do
    import ARecord
    import WrappingRecord
    r = arecord()
    wr = wrappingrecord()
  end

  defp echo_struct(_s), do: throw :nif_not_loaded
  defp echo_wrapping_struct(_s), do: throw :nif_not_loaded
  defp echo_tuple(_t), do: throw :nif_not_loaded
  defp echo_wrapping_tuple(_t), do: throw :nif_not_loaded
  defp echo_record(_t), do: throw :nif_not_loaded
  defp echo_wrapping_record(_t), do: throw :nif_not_loaded
  def echo_term(_t), do: throw :nif_not_loaded
end
