defmodule Bridge.RovingDummyGame do
  use GenServer

  defstruct players: [],
            hands: [],
            north_player: nil,
            south_player: nil,
            east_player: nil,
            west_player: nil

  def start_link(players, opts \\ []) do
    GenServer.start_link(__MODULE__, {:ok, players}, opts)
  end

  def init({:ok, players}) do
    {:ok, %Bridge.RovingDummyGame{players: players}}
  end

end