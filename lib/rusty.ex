defmodule Rusty do
  use Rustler, otp_app: :rusty, crate: "rusty"

  def trampoline(_fun_ident), do: throw :nif_not_loaded
end
