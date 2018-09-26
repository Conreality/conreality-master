defmodule Conreality.Master.Server do
  use GRPC.Server, service: Conreality.RPC.Master.Service

  @spec hello(Conreality.RPC.HelloRequest.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.HelloResponse.t()
  def hello(_request, _stream) do
    Conreality.RPC.HelloResponse.new(version: "Elixir", game: Conreality.RPC.GameInformation.new(name: "Alpha", player_count: 1)) # TODO
  end
end
