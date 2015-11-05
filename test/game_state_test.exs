defmodule GameStateTest do
  use ExUnit.Case
  doctest Bridge.GameState

  alias Bridge.GameState
  alias Bridge.Player

  test "can run through a whole game" do
    players = [
      north_south = %Player{name: "North/South"},
      east_west = %Player{name: "East/West"}
    ]
    assert {:ok, pid} = GameState.start_link(players)
    assert {:ok, ^players} = GameState.get_players(pid)

    # set a contract
    assert {:ok, contract} = GameState.set_contract(pid, [north_south], %Bridge.Contract{suit: :no_trump, bid: 3})

    # fetch the current_contract
    assert {:ok, current_contract} = GameState.get_contract(pid)
    assert %{players: [north_south]} = current_contract
  end
end
