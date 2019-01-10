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
      {:cowboy, "~> 2.5"},
      {:elixir_make, "~> 0.4.2"},
      #{:extensor, "~> 0.1.5"}, # FIXME
      {:flow, "~> 0.14.3"},
      {:geo, "~> 3.0"},
      {:geo_postgis, "~> 3.0"},
      {:geohash, "~> 1.2"},
      {:grpc, "~> 0.3.1"},
      {:matrex, "~> 0.6.7"},
      {:postgrex, "~> 0.14.1"},
      {:protobuf, "~> 0.5.4"},
      {:ranch, "~> 1.6.2"}, # TODO: upgrade to 1.7 (contingent on grpc and cowboy)
    ]
  end
end
