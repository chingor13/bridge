defmodule PlayerTest do
  use ExUnit.Case
  doctest Bridge.Player

  alias Bridge.Player

  test "can create and maintain state" do
    # start up an agent
    assert {:ok, player} = Player.start_link("Jeff")

    assert false == Player.is_vulnerable?(player)
    assert {:ok, true} = Player.set_vulnerable(player, true)
    assert true == Player.is_vulnerable?(player)
  end

end
