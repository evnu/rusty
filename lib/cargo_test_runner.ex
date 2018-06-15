defmodule CargoTestRunner do
  use Rustler, otp_app: :rusty, crate: "cargotestrunner"

  # TODO due to recompilation within the NIF, this might take a while
  @moduletag timeout: (10 * 60 * 1_000)
  def run_tests do
    # TODO this should not be hard-coded. Maybe it can be inserted from the `use` directive
    manifest_path = "/home/evnu/src/elixir/rusty/native/cargotestrunner/Cargo.toml"
    cwd = System.cwd()
    homedir = System.user_home()

    run_tests(cwd, homedir, manifest_path)
  end

  defp run_tests(cwd, homedir, manifest_path), do: :erlang.nif_error(:not_loaded)
end
