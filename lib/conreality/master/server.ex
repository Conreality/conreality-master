defmodule Conreality.Master.Server do
  @moduledoc """
  Documentation for Conreality.Master.Server.
  """

  use GRPC.Server, service: Conreality.RPC.Session.Service
  alias GRPC.Server

  @spec ping(Conreality.RPC.Nothing.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.Nothing.t()
  def ping(request, _stream) do
    IO.inspect [self(), :ping, request]

    Conreality.RPC.Nothing.new()
  end

  # Entities

  @spec lookup_entity_by_name(Conreality.RPC.TextString.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.EntityID.t()
  def lookup_entity_by_name(request, _stream) do
    IO.inspect [self(), :lookup_entity_by_name, request]

    entity_id = case Postgrex.query!(DB, "SELECT id FROM conreality.entity WHERE name = $1 LIMIT 1", [request.value]).rows do
      [] -> 0
      rows -> rows |> List.first |> List.first
    end
    Conreality.RPC.EntityID.new(id: entity_id)
  end

  # Game Info

  @spec get_game_info(Conreality.RPC.Nothing.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.GameInformation.t()
  def get_game_info(request, _stream) do
    IO.inspect [self(), :get_game_info, request]

    state = case Postgrex.query!(DB, "SELECT conreality.state() LIMIT 1", []).rows |> List.first |> List.first do
      nil -> "planned"
      "begin" -> "begun"
      "pause" -> "paused"
      "resume" -> "resumed"
      "end" -> "ended"
    end
    Conreality.RPC.GameInformation.new(
      origin: Conreality.RPC.Location.new(latitude: 49.7842250, longitude: 24.0699897, altitude: 0.0),
      radius: 100.0,
      state: state,
      title: "Garage Game",
      mission: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sodales ex sed purus imperdiet, eget commodo orci aliquet. Etiam imperdiet augue neque, vel convallis tellus consequat hendrerit. Nam rhoncus fermentum diam ut elementum."
    )
  end

  @spec get_game_state(Conreality.RPC.Nothing.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.TextString.t()
  def get_game_state(request, _stream) do
    IO.inspect [self(), :get_game_state, request]

    state = case Postgrex.query!(DB, "SELECT conreality.state() LIMIT 1", []).rows |> List.first |> List.first do
      nil -> "planned"
      "begin" -> "begun"
      "pause" -> "paused"
      "resume" -> "resumed"
      "end" -> "ended"
    end
    Conreality.RPC.TextString.new(value: state)
  end

  # Game State

  @spec start_game(Conreality.RPC.TextString.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.Nothing.t()
  def start_game(request, _stream) do
    IO.inspect [self(), :start_game, request]

    {:ok, _} = Postgrex.transaction(DB, fn(conn) ->
      case Postgrex.query!(conn, "SELECT conreality.state() LIMIT 1", []).rows |> List.first |> List.first do
        "begin" -> nil
        "pause" ->
          Postgrex.query!(conn, "INSERT INTO conreality.state (action) VALUES ($1)", ["resume"])
          Postgrex.query!(conn, "INSERT INTO conreality.event (predicate, subject, object) VALUES ($1, $2, $3) RETURNING id", ["resumed", nil, nil])
          Postgrex.query!(conn, "INSERT INTO conreality.message (text, language) VALUES ($1, $2) RETURNING id", ["Game resumed", "en-US"])
        "resume" -> nil
        _ ->
          Postgrex.query!(conn, "INSERT INTO conreality.state (action) VALUES ($1)", ["begin"])
          Postgrex.query!(conn, "INSERT INTO conreality.event (predicate, subject, object) VALUES ($1, $2, $3) RETURNING id", ["begun", nil, nil])
          Postgrex.query!(conn, "INSERT INTO conreality.message (text, language) VALUES ($1, $2) RETURNING id", ["Game started", "en-US"])
      end
    end)

    Conreality.RPC.Nothing.new()
  end

  @spec pause_game(Conreality.RPC.TextString.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.Nothing.t()
  def pause_game(request, _stream) do
    IO.inspect [self(), :pause_game, request]

    {:ok, _} = Postgrex.transaction(DB, fn(conn) ->
      case Postgrex.query!(conn, "SELECT conreality.state() LIMIT 1", []).rows |> List.first |> List.first do
        "pause" -> nil
        _ ->
          Postgrex.query!(conn, "INSERT INTO conreality.state (action) VALUES ($1)", ["pause"])
          Postgrex.query!(conn, "INSERT INTO conreality.event (predicate, subject, object) VALUES ($1, $2, $3) RETURNING id", ["paused", nil, nil])
          Postgrex.query!(conn, "INSERT INTO conreality.message (text, language) VALUES ($1, $2) RETURNING id", ["Game paused", "en-US"])
      end
    end)

    Conreality.RPC.Nothing.new()
  end

  @spec stop_game(Conreality.RPC.TextString.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.Nothing.t()
  def stop_game(request, _stream) do
    IO.inspect [self(), :stop_game, request]

    {:ok, _} = Postgrex.transaction(DB, fn(conn) ->
      case Postgrex.query!(conn, "SELECT conreality.state() LIMIT 1", []).rows |> List.first |> List.first do
        "end" -> nil
        _ ->
          Postgrex.query!(conn, "INSERT INTO conreality.state (action) VALUES ($1)", ["end"])
          Postgrex.query!(conn, "INSERT INTO conreality.event (predicate, subject, object) VALUES ($1, $2, $3) RETURNING id", ["ended", nil, nil])
          Postgrex.query!(conn, "INSERT INTO conreality.message (text, language) VALUES ($1, $2) RETURNING id", ["Game stopped", "en-US"])
      end
    end)

    Conreality.RPC.Nothing.new()
  end

  # Game State

  @spec join_game(Conreality.RPC.Nothing.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.PlayerID.t()
  def join_game(request, _stream) do
    IO.inspect [self(), :join_game, request]

    Conreality.RPC.PlayerID.new(id: 0) # TODO
  end

  @spec leave_game(Conreality.RPC.TextString.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.Nothing.t()
  def leave_game(request, _stream) do
    IO.inspect [self(), :leave_game, request]

    Conreality.RPC.Nothing.new() # TODO
  end

  # Theater/Mission

  @spec define_theater(Conreality.RPC.Box.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.Nothing.t()
  def define_theater(request, _stream) do
    IO.inspect [self(), :define_theater, request]

    Conreality.RPC.Nothing.new() # TODO
  end

  @spec define_mission(Conreality.RPC.TextString.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.Nothing.t()
  def define_mission(request, _stream) do
    IO.inspect [self(), :define_mission, request]

    Conreality.RPC.Nothing.new() # TODO
  end

  # Players

  @spec add_player(Conreality.RPC.Player.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.PlayerID.t()
  def add_player(request, _stream) do
    IO.inspect [self(), :add_player, request]

    {:ok, player_id} = Postgrex.transaction(DB, fn(conn) ->
      player_id = Postgrex.query!(conn, "INSERT INTO conreality.entity (type, name) VALUES ($1, $2) RETURNING id", ["player", request.nick]).rows |> List.first |> List.first
      Postgrex.query!(conn, "INSERT INTO conreality.object (id) VALUES ($1)", [player_id])
      Postgrex.query!(conn, "INSERT INTO conreality.player (id, nick) VALUES ($1, $2)", [player_id, request.nick])
      player_id
    end)
    Conreality.RPC.PlayerID.new(id: player_id)
  end

  @spec list_players(Conreality.RPC.UnitID.t(), GRPC.Server.Stream.t()) :: any
  def list_players(request, stream) do
    IO.inspect [self(), :list_players, request]

    # List all existing players:
    case Postgrex.query!(DB, "SELECT id, nick, NULL as language, rank, NULL AS bio FROM conreality.player ORDER BY id ASC", []) do # TODO: filter by request.id
      %Postgrex.Result{num_rows: 0} -> nil
      %Postgrex.Result{num_rows: _, rows: rows} ->
        for row <- rows do
          Server.send_reply(stream, make_player(row))
        end
    end

    # TODO: subscribe to players who join going forward
  end

  @spec receive_player_statuses(Conreality.RPC.UnitID.t(), GRPC.Server.Stream.t()) :: any
  def receive_player_statuses(request, stream) do
    IO.inspect [self(), :receive_player_statuses, request]

    # Subscribe to future statuses:
    {:ok, pid, ref} = listen("player_status")

    # Relay any future events:
    listen_loop(pid, ref, "player_status", fn(id) ->
      #IO.inspect [self(), :receive_player_statuses, :id, id]
      case Postgrex.query!(DB, "SELECT id, timestamp, player, state, latitude, longitude, altitude, heartrate FROM conreality.player_status WHERE id = $1 LIMIT 1", [id]) do
        %Postgrex.Result{num_rows: 0} -> nil
        %Postgrex.Result{num_rows: 1, rows: [row]} ->
          #IO.inspect [self(), :receive_player_statuses, :row, row
          Server.send_reply(stream, make_player_status(row))
      end
    end)
  end

  @spec update_player(Conreality.RPC.PlayerStatus.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.Nothing.t()
  def update_player(request, _stream) do
    IO.inspect [self(), :update_player, request]

    query = "INSERT INTO conreality.player_status (player, state, latitude, longitude, altitude, heartrate) VALUES ($1, $2, $3, $4, $5, $6) RETURNING id"
    Postgrex.query!(DB, query, [
      request.player_id,
      (if request.state != "", do: request.state, else: nil),
      (if request.location, do: request.location.latitude, else: nil),
      (if request.location, do: request.location.longitude, else: nil),
      (if request.location, do: request.location.altitude, else: nil),
      request.heartrate,
    ])

    Conreality.RPC.Nothing.new()
  end

  # Units

  @spec disband_unit(Conreality.RPC.UnitID.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.Nothing.t()
  def disband_unit(request, _stream) do
    IO.inspect [self(), :disband_unit, request]

    Postgrex.query!(DB, "DELETE FROM conreality.entity WHERE id = $1 AND type = $2", [request.value, "unit"])
    Conreality.RPC.Nothing.new()
  end

  @spec form_unit(Conreality.RPC.TextString.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.UnitID.t()
  def form_unit(request, _stream) do
    IO.inspect [self(), :form_unit, request]

    {:ok, unit_id} = Postgrex.transaction(DB, fn(conn) ->
      result = Postgrex.query!(conn, "INSERT INTO conreality.entity (type) VALUES ($1) RETURNING id", ["unit"])
      unit_id = result.rows |> List.first |> List.first
      Postgrex.query!(conn, "INSERT INTO conreality.group (id, label) VALUES ($1, $2)", [unit_id, request.value])
      Postgrex.query!(conn, "INSERT INTO conreality.unit (id) VALUES ($1)", [unit_id])
      unit_id
    end)
    Conreality.RPC.UnitID.new(id: unit_id)
  end

  @spec join_unit(Conreality.RPC.UnitID.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.Nothing.t()
  def join_unit(request, _stream) do
    IO.inspect [self(), :join_unit, request]

    Conreality.RPC.Nothing.new() # TODO
  end

  @spec leave_unit(Conreality.RPC.UnitID.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.Nothing.t()
  def leave_unit(request, _stream) do
    IO.inspect [self(), :leave_unit, request]

    Conreality.RPC.Nothing.new() # TODO
  end

  @spec list_units(Conreality.RPC.UnitID.t(), GRPC.Server.Stream.t()) :: any
  def list_units(request, stream) do
    IO.inspect [self(), :list_units, request]

    # List all existing units:
    case Postgrex.query!(DB, "SELECT id, label FROM conreality.group ORDER BY id ASC", []) do # TODO: filter by request.id
      %Postgrex.Result{num_rows: 0} -> nil
      %Postgrex.Result{num_rows: _, rows: rows} ->
        for row <- rows do
          Server.send_reply(stream, make_unit(row))
        end
    end

    # TODO: subscribe to units formed going forward
  end

  # Targets

  @spec designate_target(Conreality.RPC.Target.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.TargetID.t()
  def designate_target(request, _stream) do
    IO.inspect [self(), :designate_target, request]

    {:ok, target_id} = Postgrex.transaction(DB, fn(conn) ->
      target_id = Postgrex.query!(conn, "INSERT INTO conreality.entity (type) VALUES ($1) RETURNING id", ["target"]).rows |> List.first |> List.first
      Postgrex.query!(conn, "INSERT INTO conreality.object (id) VALUES ($1)", [target_id]) # TODO: use label
      Postgrex.query!(conn, "INSERT INTO conreality.target (id) VALUES ($1)", [target_id]) # TODO: use coordinates
      target_id
    end)
    Conreality.RPC.TargetID.new(id: target_id)
  end

  @spec list_targets(Conreality.RPC.UnitID.t(), GRPC.Server.Stream.t()) :: any
  def list_targets(request, stream) do
    IO.inspect [self(), :list_targets, request]

    # List all existing targets:
    case Postgrex.query!(DB, "SELECT id FROM conreality.target ORDER BY id ASC", []) do # TODO: filter by request.id
      %Postgrex.Result{num_rows: 0} -> nil
      %Postgrex.Result{num_rows: _, rows: rows} ->
        for row <- rows do
          Server.send_reply(stream, make_target(row))
        end
    end

    # TODO: subscribe to targets designated going forward
  end

  # Broadcasts

  @spec send_event(Conreality.RPC.Event.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.EventID.t()
  def send_event(request, _stream) do
    IO.inspect [self(), :send_event, request]

    query = "INSERT INTO conreality.event (predicate, subject, object) VALUES ($1, $2, $3) RETURNING id"
    result = Postgrex.query!(DB, query, [
      request.predicate,
      (if request.subject_id > 0, do: request.subject_id, else: nil),
      (if request.object_id > 0, do: request.object_id, else: nil),
    ])
    event_id = result.rows |> List.first |> List.first

    Conreality.RPC.EventID.new(id: event_id)
  end

  @spec receive_events(Conreality.RPC.EventID.t(), GRPC.Server.Stream.t()) :: any
  def receive_events(request, stream) do
    IO.inspect [self(), :receive_events, request]

    # Subscribe to future events:
    {:ok, pid, ref} = listen("event")

    # Replay all previous events:
    case Postgrex.query!(DB, "SELECT id, timestamp, predicate, subject, object FROM conreality.event WHERE id > $1 ORDER BY id ASC", [request.id]) do
      %Postgrex.Result{num_rows: 0} -> nil
      %Postgrex.Result{num_rows: _, rows: rows} ->
        for row <- rows do
          Server.send_reply(stream, make_event(row))
        end
    end

    # Relay any future events:
    listen_loop(pid, ref, "event", fn(id) ->
      #IO.inspect [self(), :receive_events, :id, id]
      case Postgrex.query!(DB, "SELECT id, timestamp, predicate, subject, object FROM conreality.event WHERE id = $1 LIMIT 1", [id]) do
        %Postgrex.Result{num_rows: 0} -> nil
        %Postgrex.Result{num_rows: 1, rows: [row]} ->
          #IO.inspect [self(), :receive_events, :row, row
          Server.send_reply(stream, make_event(row))
      end
    end)
  end

  @spec send_message(Conreality.RPC.Message.t(), GRPC.Server.Stream.t()) :: Conreality.RPC.MessageID.t()
  def send_message(request, _stream) do
    IO.inspect [self(), :send_message, request]

    query = "INSERT INTO conreality.message (sender, recipient, text, audio) VALUES ($1, $2, $3, $4) RETURNING id"
    result = Postgrex.query!(DB, query, [
      (if request.sender_id > 0, do: request.sender_id, else: nil),
      (if request.recipient_id > 0, do: request.recipient_id, else: nil),
      request.text,
      nil, # TODO
    ])
    message_id = result.rows |> List.first |> List.first

    Conreality.RPC.MessageID.new(id: message_id)
  end

  @spec receive_messages(Conreality.RPC.MessageID.t(), GRPC.Server.Stream.t()) :: any
  def receive_messages(request, stream) do
    IO.inspect [self(), :receive_messages, request]

    # Subscribe to future messages:
    {:ok, pid, ref} = listen("message")

    # Replay all previous messages:
    case Postgrex.query!(DB, "SELECT id, timestamp, sender, recipient, text FROM conreality.message WHERE id > $1 ORDER BY id ASC", [request.id]) do
      %Postgrex.Result{num_rows: 0} -> nil
      %Postgrex.Result{num_rows: _, rows: rows} ->
        for row <- rows do
          Server.send_reply(stream, make_message(row))
        end
    end

    # Relay any future messages:
    listen_loop(pid, ref, "message", fn(id) ->
      #IO.inspect [self(), :receive_messages, :id, id]
      case Postgrex.query!(DB, "SELECT id, timestamp, sender, recipient, text FROM conreality.message WHERE id = $1 LIMIT 1", [id]) do
        %Postgrex.Result{num_rows: 0} -> nil
        %Postgrex.Result{num_rows: 1, rows: [row]} ->
          #IO.inspect [self(), :receive_messages, :row, row
          Server.send_reply(stream, make_message(row))
      end
    end)
  end

  defp make_event([id, timestamp, predicate, subject, object]) do
    Conreality.RPC.Event.new(
      id: id,
      timestamp: timestamp |> DateTime.to_unix,
      predicate: predicate,
      subject_id: subject || 0,
      object_id: object || 0
    )
  end

  defp make_message([id, timestamp, sender, recipient, text]) do
    Conreality.RPC.Message.new(
      id: id,
      timestamp: timestamp |> DateTime.to_unix,
      sender_id: sender || 0,
      recipient_id: recipient || 0,
      language: "", # TODO
      text: text
    )
  end

  defp make_player([id, nick, language, rank, bio]) do
    Conreality.RPC.Player.new(
      id: id,
      nick: nick,
      language: language || "",
      rank: rank || "",
      bio: bio || "",
      avatar: "" # TODO
    )
  end

  defp make_player_status([_id, _timestamp, player, state, latitude, longitude, altitude, heartrate]) do
    Conreality.RPC.PlayerStatus.new(
      player_id: player,
      state: state || "",
      headset: false,
      heartrate: heartrate || 0,
      location: Conreality.RPC.Location.new(
        latitude: latitude,
        longitude: longitude,
        altitude: altitude
      )
    )
  end

  defp make_target([id]) do
    Conreality.RPC.Target.new(id: id)
  end

  defp make_unit([id, name]) do
    Conreality.RPC.Unit.new(id: id, name: name)
  end

  defp listen(channel) do
    {:ok, pid} = Postgrex.Notifications.start_link([hostname: "localhost", database: "demo"]) # FIXME
    ref = Postgrex.Notifications.listen!(pid, channel)
    {:ok, pid, ref}
  end

  defp listen_loop(pid, ref, channel, callback) do
    receive do
      {:notification, ^pid, ^ref, ^channel, payload} ->
        callback.(payload |> String.to_integer)
        listen_loop(pid, ref, channel, callback)
    end
  end
end
