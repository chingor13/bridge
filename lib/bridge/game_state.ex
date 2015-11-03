defmodule Bridge.GameState do
  use GenServer

  defmodule HandHistory do
    defstruct contract: nil, tricks_made: 0, results: nil
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

  ## Server Callbacks

  def init(:ok) do
    {:ok, %Bridge.GameState{}}
  end

  def handle_call({:set_contract, contract}, _from, state) do
    state = %Bridge.GameState{ state | current_contract: contract }
    {:reply, contract, state}
  end
  def handle_call({:get_contract}, _from, state) do
    {:reply, state.current_contract, state}
  end

end