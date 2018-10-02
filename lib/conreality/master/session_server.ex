defmodule Conreality.Master.Session.Server do
  use GRPC.Server, service: Conreality.RPC.Session.Service

  @spec ping(Conreality.RPC.PingRequest.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.PongResponse.t()
  def ping(_request, _stream) do
    Conreality.RPC.PongResponse.new()
  end

  @spec send_event(Conreality.RPC.SendEventRequest.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.IDResponse.t()
  def send_event(_request, _stream) do
    Conreality.RPC.IDResponse.new(id: 0) # TODO
  end

  @spec send_message(Conreality.RPC.SendMessageRequest.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.IDResponse.t()
  def send_message(_request, _stream) do
    Conreality.RPC.IDResponse.new(id: 0) # TODO
  end

  @spec update_player(Conreality.RPC.UpdatePlayerRequest.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.EmptyResponse.t()
  def update_player(_request, _stream) do
    Conreality.RPC.EmptyResponse.new() # TODO
  end
end
