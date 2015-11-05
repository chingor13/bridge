defmodule Bridge.GameState do
  use GenServer

  defmodule HandHistory do
    defstruct contract: nil, result: nil
  end

  defmodule HandResult do
    defstruct tricks_made: 0, honors: 0
  end

  defstruct hands: [], contract: nil, players: []

  ## Client API

  @doc """
  Starts the game.
  """
  def start_link(players, opts \\ []) do
    GenServer.start_link(__MODULE__, {:ok, players}, opts)
  end

  def set_contract(server, players, contract) do
    GenServer.call(server, {:set_contract, players, contract})
  end

  def get_contract(server) do
    GenServer.call(server, {:get_contract})
  end

  def complete_hand(server, tricks_made, honors) do
    record_result(server, %Bridge.GameState.HandResult{tricks_made: tricks_made, honors: honors})
  end

  def record_result(server, result) do
    GenServer.call(server, {:record_result, result})
  end

  def get_hands(server) do
    GenServer.call(server, {:get_hands})
  end

  def get_players(server) do
    GenServer.call(server, {:get_players})
  end

  ## Server Callbacks

  def init({:ok, players}) do
    {:ok, %Bridge.GameState{players: players}}
  end

  def handle_call({:set_contract, players, contract}, _from, state) do
    vulnerable = Enum.any?(players, fn (player) -> player.vulnerable end)
    contract = %{ contract | players: players, vulnerable: vulnerable }
    {:reply, {:ok, contract}, %{ state | contract: contract }}
  end 
  def handle_call({:get_contract}, _from, state) do
    {:reply, {:ok, state.contract}, state}
  end

  def handle_call({:record_result, _result}, _from, state = %Bridge.GameState{contract: nil}) do
    {:reply, {:error, "no contract set"}, state}
  end
  def handle_call({:record_result, result}, _from, state) do
    entry = %Bridge.GameState.HandHistory{contract: state.contract, result: result}
    state = %Bridge.GameState{ hands: [entry | state.hands], contract: nil}
    {:reply, {:ok, result}, state}
  end

  def handle_call({:get_hands}, _from, state) do
    {:reply, {:ok, state.hands}, state}
  end
  def handle_call({:get_players}, _from, state) do
    {:reply, {:ok, state.players}, state}
  end
end