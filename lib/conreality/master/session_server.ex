defmodule Conreality.Master.Session.Server do
  use GRPC.Server, service: Conreality.RPC.Session.Service

  @spec ping(Conreality.RPC.Nothing.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.Nothing.t()
  def ping(_request, _stream) do
    Conreality.RPC.Nothing.new()
  end

  @spec send_event(Conreality.RPC.Event.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.EventID.t()
  def send_event(_request, _stream) do
    Conreality.RPC.EventID.new(id: 0) # TODO
  end

  @spec send_message(Conreality.RPC.Message.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.MessageID.t()
  def send_message(_request, _stream) do
    Conreality.RPC.MessageID.new(id: 0) # TODO
  end

  @spec update_player(Conreality.RPC.PlayerStatus.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.Nothing.t()
  def update_player(_request, _stream) do
    Conreality.RPC.Nothing.new() # TODO
  end
end
