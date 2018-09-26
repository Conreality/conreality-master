defmodule Conreality.MasterTest do
  use ExUnit.Case
  doctest Conreality.Master

  test "greets the world" do
    assert Conreality.Master.hello() == :world
  end
end
