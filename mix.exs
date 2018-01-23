defmodule Rusty.Mixfile do
  use Mix.Project

  def project do
    [
      app: :rusty,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps(),
      compilers: [:rustler] ++ Mix.compilers(),
      rustler_crates: rustler_crates()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:rustler, git: "https://github.com/hansihe/rustler", sparse: "rustler_mix"},
      {:benchee, "~>0.11"},
      {:propcheck, "~> 1.0", only: :test}
    ]
  end

  defp rustler_crates do
    [
      rusty: [
        path: "native/rusty",
        mode: :release
      ]
    ]
  end
end
