defmodule Conreality.Master.Application do
  @moduledoc """
  Documentation for Conreality.Master.Application.
  """

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications

  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    # List all child processes to be supervised:
    children = [
      Postgrex.child_spec([name: DB, hostname: "localhost", database: "demo"]), # FIXME
      supervisor(GRPC.Server.Supervisor, [{[Conreality.Master.Server], 50051}]),
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Conreality.Master.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
