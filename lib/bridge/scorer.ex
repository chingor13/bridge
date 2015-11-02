defmodule Bridge.Scorer do

  @moduledoc """
  This module handles figuring out the score for a contract bridge hand
  """

  @doc """
  Given a contract struct and boolean for if the contract is made, figure out
  how many points to award to each side

  Returns a tuple of {offsive_above_line, offensive_below_line, defensive_above_line}
  """
  def score(contract, tricks_made) do
    {bonus_points(contract, tricks_made), contract_points(contract, tricks_made), defensive_points(contract, tricks_made)}
  end

  defp defensive_points(%Bridge.Contract{bid: bid}, tricks_made) when tricks_made >= bid + 6, do: 0
  defp defensive_points(contract = %Bridge.Contract{vulnerable: true, redoubled: true}, tricks_made) do
    missed_by(contract, tricks_made)
      |> scaled(400, 600)
  end
  defp defensive_points(contract = %Bridge.Contract{vulnerable: true, doubled: true}, tricks_made) do
    missed_by(contract, tricks_made)
      |> scaled(200, 300)
  end
  defp defensive_points(contract = %Bridge.Contract{vulnerable: true}, tricks_made) do
    missed_by(contract, tricks_made)
      |> scaled(100)
  end
  defp defensive_points(contract = %Bridge.Contract{redoubled: true}, tricks_made) do
    missed_by(contract, tricks_made)
      |> scaled(200, 400, 600)
  end
  defp defensive_points(contract = %Bridge.Contract{doubled: true}, tricks_made) do
    missed_by(contract, tricks_made)
      |> scaled(100, 200, 300)
  end
  defp defensive_points(contract, tricks_made) do
    missed_by(contract, tricks_made)
      |> scaled(50)
  end

  defp contract_points(%Bridge.Contract{bid: bid}, tricks_made) when tricks_made < bid + 6, do: 0
  defp contract_points(contract = %Bridge.Contract{suit: suit, bid: bid, redoubled: true}, _) do
    4 * trick_values(suit, bid)
  end
  defp contract_points(contract = %Bridge.Contract{suit: suit, bid: bid, doubled: true}, _) do
    2 * trick_values(suit, bid)
  end
  defp contract_points(contract = %Bridge.Contract{suit: suit, bid: bid}, _) do
    trick_values(suit, bid)
  end

  # no bonus when you don't make your contract
  defp bonus_points(%Bridge.Contract{bid: bid}, tricks_made) when tricks_made < bid + 6, do: 0
  defp bonus_points(contract, tricks_made) do
    slam_bonus(contract) + overtrick_bonus(contract, tricks_made) + insult_bonus(contract)
  end

  defp slam_bonus(%Bridge.Contract{bid: 6, vulnerable: false}), do: 500
  defp slam_bonus(%Bridge.Contract{bid: 6, vulnerable: true}),  do: 1000
  defp slam_bonus(%Bridge.Contract{bid: 7, vulnerable: false}), do: 750
  defp slam_bonus(%Bridge.Contract{bid: 7, vulnerable: true}),  do: 1500
  defp slam_bonus(_),                                           do: 0

  # no bonus when you don't make overtricks
  defp overtrick_bonus(%Bridge.Contract{bid: bid}, tricks_made) when tricks_made <= bid + 6, do: 0
  defp overtrick_bonus(contract = %Bridge.Contract{bid: bid}, tricks_made) do
    overtricks(contract, tricks_made) * overtrick_values(contract)
  end

  defp insult_bonus(%Bridge.Contract{redoubled: true}), do: 100
  defp insult_bonus(%Bridge.Contract{doubled: true}),   do: 50
  defp insult_bonus(_),                                 do: 0

  defp missed_by(%Bridge.Contract{bid: bid}, tricks_made) when tricks_made < bid + 6 do
    bid + 6 - tricks_made
  end
  defp missed_by(_, _), do: 0

  defp overtricks(%Bridge.Contract{bid: bid}, tricks_made) when tricks_made > bid + 6 do
    tricks_made - bid - 6
  end
  defp overtricks(_, _), do: 0

  defp scaled(amount, factor), do: amount * factor
  defp scaled(0, _, _), do: 0
  defp scaled(amount, first, others) do
    first + (amount - 1) * others
  end
  defp scaled(amount, first, second_third, _) when amount < 4 do
    scaled(amount, first, second_third)
  end
  defp scaled(amount, first, second_third, others) do
    scaled(3, first, second_third) + (amount - 3) * others
  end

  defp trick_values(:no_trump, number), do: number |> scaled(40, 30)
  defp trick_values(:clubs, number),    do: 20 * number
  defp trick_values(:diamonds, number), do: 20 * number
  defp trick_values(_, number),         do: 30 * number

  defp overtrick_values(%Bridge.Contract{redoubled: true, vulnerable: true}), do: 400
  defp overtrick_values(%Bridge.Contract{redoubled: true}),                   do: 200
  defp overtrick_values(%Bridge.Contract{doubled: true, vulnerable: true}),   do: 200
  defp overtrick_values(%Bridge.Contract{doubled: true}),                     do: 100
  defp overtrick_values(%Bridge.Contract{suit: :clubs}),                      do: 20
  defp overtrick_values(%Bridge.Contract{suit: :diamonds}),                   do: 20
  defp overtrick_values(_),                                                   do: 30
end