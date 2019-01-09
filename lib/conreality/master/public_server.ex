defmodule Conreality.Master.Public.Server do
  use GRPC.Server, service: Conreality.RPC.Public.Service

  @spec authenticate(Conreality.RPC.AuthRequest.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.AuthResponse.t()
  def authenticate(_request, _stream) do
    Conreality.RPC.AuthResponse.new(session_id: 0) # TODO
  end

  @spec bye(Conreality.RPC.Nothing.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.Nothing.t()
  def bye(_request, _stream) do
    Conreality.RPC.Nothing.new()
  end

  @spec hello(Conreality.RPC.HelloRequest.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.HelloResponse.t()
  def hello(_request, _stream) do
    Conreality.RPC.HelloResponse.new(version: "Elixir") # TODO
  end

  @spec ping(Conreality.RPC.Nothing.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.Nothing.t()
  def ping(_request, _stream) do
    Conreality.RPC.Nothing.new()
  end
end
