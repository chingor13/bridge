defmodule Bridge.GameState do
  use GenServer

  defmodule HandHistory do
    defstruct contract: nil, result: nil
  end

  defmodule HandResult do
    defstruct tricks_made: 0, honors: 0
  end

  defstruct hands: [], current_contract: nil

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

  ## Server Callbacks

  def init(:ok) do
    {:ok, %Bridge.GameState{}}
  end

  def handle_call({:set_contract, contract}, _from, state) do
    state = %Bridge.GameState{ state | current_contract: contract }
    {:reply, {:ok, contract}, state}
  end 
  def handle_call({:get_contract}, _from, state) do
    {:reply, {:ok, state.current_contract}, state}
  end

  def handle_call({:record_result, result}, _from, state = %Bridge.GameState{current_contract: nil}) do
    {:reply, {:error, "no contract set"}, state}
  end
  def handle_call({:record_result, result}, _from, state) do
    entry = %Bridge.GameState.HandHistory{contract: state.current_contract, result: result}
    state = %Bridge.GameState{ hands: [entry | state.hands], current_contract: nil}
    {:reply, {:ok, result}, state}
  end

end