defmodule Conreality.Master.Session.Server do
  use GRPC.Server, service: Conreality.RPC.Session.Service

  @spec ping(Conreality.RPC.Nothing.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.Nothing.t()
  def ping(request, _stream) do
    IO.inspect [:ping, request]
    Conreality.RPC.Nothing.new()
  end

  # Game

  @spec join_game(Conreality.RPC.Nothing.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.PlayerID.t()
  def join_game(request, _stream) do
    IO.inspect [:join_game, request]
    Conreality.RPC.PlayerID.new(value: 0) # TODO
  end

  @spec leave_game(Conreality.RPC.String.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.Nothing.t()
  def leave_game(request, _stream) do
    IO.inspect [:leave_game, request]
    Conreality.RPC.Nothing.new() # TODO
  end

  @spec pause_game(Conreality.RPC.String.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.Nothing.t()
  def pause_game(request, _stream) do
    IO.inspect [:pause_game, request]
    Conreality.RPC.Nothing.new() # TODO
  end

  @spec start_game(Conreality.RPC.String.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.Nothing.t()
  def start_game(request, _stream) do
    IO.inspect [:start_game, request]
    Conreality.RPC.Nothing.new() # TODO
  end

  @spec stop_game(Conreality.RPC.String.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.Nothing.t()
  def stop_game(request, _stream) do
    IO.inspect [:stop_game, request]
    Conreality.RPC.Nothing.new() # TODO
  end

  # Theater

  @spec define_theater(Conreality.RPC.Box.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.Nothing.t()
  def define_theater(request, _stream) do
    IO.inspect [:define_theater, request]
    Conreality.RPC.Nothing.new() # TODO
  end

  # Mission

  @spec define_mission(Conreality.RPC.String.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.Nothing.t()
  def define_mission(request, _stream) do
    IO.inspect [:define_mission, request]
    Conreality.RPC.Nothing.new() # TODO
  end

  # Players

  @spec add_player(Conreality.RPC.Player.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.PlayerID.t()
  def add_player(request, _stream) do
    IO.inspect [:add_player, request]
    Conreality.RPC.PlayerID.new(value: 0) # TODO
  end

  @spec list_players(Conreality.RPC.UnitID.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.PlayerList.t()
  def list_players(request, _stream) do
    IO.inspect [:list_players, request]
    Conreality.RPC.PlayerList.new(values: [Conreality.RPC.PlayerID.new(value: 42)]) # TODO
  end

  @spec update_player(Conreality.RPC.PlayerStatus.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.Nothing.t()
  def update_player(request, _stream) do
    IO.inspect [:update_player, request]
    Conreality.RPC.Nothing.new() # TODO
  end

  # Units

  @spec disband_unit(Conreality.RPC.UnitID.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.Nothing.t()
  def disband_unit(request, _stream) do
    IO.inspect [:disband_unit, request]
    Conreality.RPC.Nothing.new() # TODO
  end

  @spec form_unit(Conreality.RPC.String.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.UnitID.t()
  def form_unit(request, _stream) do
    IO.inspect [:form_unit, request]
    Conreality.RPC.UnitID.new(value: 0) # TODO
  end

  @spec join_unit(Conreality.RPC.UnitID.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.Nothing.t()
  def join_unit(request, _stream) do
    IO.inspect [:join_unit, request]
    Conreality.RPC.Nothing.new() # TODO
  end

  @spec leave_unit(Conreality.RPC.UnitID.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.Nothing.t()
  def leave_unit(request, _stream) do
    IO.inspect [:leave_unit, request]
    Conreality.RPC.Nothing.new() # TODO
  end

  @spec list_units(Conreality.RPC.Nothing.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.UnitList.t()
  def list_units(request, _stream) do
    IO.inspect [:list_units, request]
    Conreality.RPC.UnitList.new(values: [Conreality.RPC.UnitID.new(value: 42)]) # TODO
  end

  # Targets

  @spec designate_target(Conreality.RPC.Target.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.TargetID.t()
  def designate_target(request, _stream) do
    IO.inspect [:designate_target, request]
    Conreality.RPC.TargetID.new(value: 0) # TODO
  end

  @spec list_targets(Conreality.RPC.UnitID.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.TargetList.t()
  def list_targets(request, _stream) do
    IO.inspect [:list_targets, request]
    Conreality.RPC.TargetList.new(values: [Conreality.RPC.TargetID.new(value: 42)]) # TODO
  end

  # Broadcasts

  @spec send_event(Conreality.RPC.Event.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.EventID.t()
  def send_event(request, _stream) do
    IO.inspect [:send_event, request]
    Conreality.RPC.EventID.new(value: 0) # TODO
  end

  @spec send_message(Conreality.RPC.Message.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.MessageID.t()
  def send_message(request, _stream) do
    IO.inspect [:send_message, request]
    Conreality.RPC.MessageID.new(value: 0) # TODO
  end
end
