defmodule Bridge.Player do
  use GenServer

  defstruct name: "", vulnerable: false

  ## Client API

  @doc """
  Starts the game.
  """
  def start_link(name, opts \\ []) do
    GenServer.start_link(__MODULE__, {:ok, name}, opts)
  end

  ## Server Callbacks

  def init({:ok, name}) do
    {:ok, %Bridge.Player{name: name}}
  end

  def handle_call({:set_vulnerable, is_vulnerable}, _from, state) do
    {:reply, {:ok, is_vulnerable}, %{ state | vulnerable: is_vulnerable }}
  end

end