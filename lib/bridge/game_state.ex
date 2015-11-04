defmodule Bridge.GameState do
  use GenServer

  defmodule HandHistory do
    defstruct contract: nil, result: nil
  end

  defmodule HandResult do
    defstruct tricks_made: 0, honors: 0
  end

  defstruct hands: [], contract: nil

  ## Client API

  @doc """
  Starts the game.
  """
  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def set_contract(server, contract) do
    GenServer.call(server, {:set_contract, contract})
  end

  def get_contract(server) do
    GenServer.call(server, {:get_contract})
  end

  def record_result(server, result) do
    GenServer.call(server, {:record_result, result})
  end

  def get_hands(server) do
    GenServer.call(server, {:get_hands})
  end

  ## Server Callbacks

  def init(:ok) do
    {:ok, %Bridge.GameState{}}
  end

  def handle_call({:set_contract, contract}, _from, state) do
    state = %Bridge.GameState{ state | contract: contract }
    {:reply, {:ok, contract}, state}
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
end