defmodule Conreality.Master.MixProject do
  use Mix.Project

  @name      "Conreality Master"
  @version   File.read!("VERSION") |> String.trim
  @github    "https://github.com/conreality/conreality-master"
  @bitbucket "https://bitbucket.org/conreality/conreality-master"
  @homepage  "https://conreality.org"

  def project do
    [
      app: :conreality_master,
      version: @version,
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      name: @name,
      source_url: @github,
      homepage_url: @homepage,
      description: description(),
      package: package(),
      docs: [source_ref: @version, main: "readme", extras: []],
      deps: deps(),
    ]
  end

  def application do
    [
      mod: {Conreality.Master.Application, []},
      extra_applications: [:logger],
    ]
  end

  defp package do
    [
      files: ~w(lib priv src mix.exs CHANGES.rst README.rst UNLICENSE VERSION),
      maintainers: ["Conreality.org"],
      licenses: ["Public Domain"],
      links: %{"GitHub" => @github, "Bitbucket" => @bitbucket},
    ]
  end

  defp description do
    """
    Conreality master server.
    """
  end

  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end
end
