defmodule Conreality.Master.Session.Server do
  use GRPC.Server, service: Conreality.RPC.Session.Service

  @spec ping(Conreality.RPC.Nothing.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.Nothing.t()
  def ping(_request, _stream) do
    Conreality.RPC.Nothing.new()
  end

  # Game

  @spec join_game(Conreality.RPC.Nothing.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.PlayerID.t()
  def join_game(_request, _stream) do
    Conreality.RPC.PlayerID.new(value: 0) # TODO
  end

  @spec leave_game(Conreality.RPC.String.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.Nothing.t()
  def leave_game(_request, _stream) do
    Conreality.RPC.Nothing.new() # TODO
  end

  @spec pause_game(Conreality.RPC.Nothing.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.Nothing.t()
  def pause_game(_request, _stream) do
    Conreality.RPC.Nothing.new() # TODO
  end

  @spec start_game(Conreality.RPC.Nothing.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.Nothing.t()
  def start_game(_request, _stream) do
    Conreality.RPC.Nothing.new() # TODO
  end

  @spec stop_game(Conreality.RPC.Nothing.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.Nothing.t()
  def stop_game(_request, _stream) do
    Conreality.RPC.Nothing.new() # TODO
  end

  # Theater

  @spec define_theater(Conreality.RPC.Box.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.Nothing.t()
  def define_theater(_request, _stream) do
    Conreality.RPC.Nothing.new() # TODO
  end

  # Mission

  @spec define_mission(Conreality.RPC.String.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.Nothing.t()
  def define_mission(_request, _stream) do
    Conreality.RPC.Nothing.new() # TODO
  end

  # Players

  @spec add_player(Conreality.RPC.Player.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.PlayerID.t()
  def add_player(_request, _stream) do
    Conreality.RPC.PlayerID.new(value: 0) # TODO
  end

  @spec list_players(Conreality.RPC.Nothing.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.PlayerList.t()
  def list_players(_request, _stream) do
    Conreality.RPC.PlayerList.new() # TODO
  end

  @spec update_player(Conreality.RPC.PlayerStatus.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.Nothing.t()
  def update_player(_request, _stream) do
    Conreality.RPC.Nothing.new() # TODO
  end

  # Units

  @spec disband_unit(Conreality.RPC.UnitID.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.Nothing.t()
  def disband_unit(_request, _stream) do
    Conreality.RPC.Nothing.new() # TODO
  end

  @spec form_unit(Conreality.RPC.String.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.UnitID.t()
  def form_unit(_request, _stream) do
    Conreality.RPC.UnitID.new(value: 0) # TODO
  end

  @spec join_unit(Conreality.RPC.UnitID.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.Nothing.t()
  def join_unit(_request, _stream) do
    Conreality.RPC.Nothing.new() # TODO
  end

  @spec leave_unit(Conreality.RPC.UnitID.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.Nothing.t()
  def leave_unit(_request, _stream) do
    Conreality.RPC.Nothing.new() # TODO
  end

  @spec list_units(Conreality.RPC.Nothing.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.UnitList.t()
  def list_units(_request, _stream) do
    Conreality.RPC.UnitList.new() # TODO
  end

  # Targets

  @spec designate_target(Conreality.RPC.Target.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.TargetID.t()
  def designate_target(_request, _stream) do
    Conreality.RPC.TargetID.new(value: 0) # TODO
  end

  @spec list_targets(Conreality.RPC.Nothing.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.TargetList.t()
  def list_targets(_request, _stream) do
    Conreality.RPC.TargetList.new() # TODO
  end

  # Broadcasts

  @spec send_event(Conreality.RPC.Event.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.EventID.t()
  def send_event(_request, _stream) do
    Conreality.RPC.EventID.new(value: 0) # TODO
  end

  @spec send_message(Conreality.RPC.Message.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.MessageID.t()
  def send_message(_request, _stream) do
    Conreality.RPC.MessageID.new(value: 0) # TODO
  end
end
