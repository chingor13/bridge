defmodule Bridge.Scorer do

  @moduledoc """
  This module handles figuring out the score for a contract bridge hand
  """

  @doc """
  Given a contract struct and boolean for if the contract is made, figure out
  how many points to award to each side

  Returns a tuple of {offsive_above_line, offensive_below_line, defensive_above_line}
  """
  def score(contract = %Bridge.Contract{suit: suit, bid: bid, redoubled: true}, tricks_made) when tricks_made >= bid + 6 do
    {100 + overtrick_values(contract) * (tricks_made - bid - 6), 4 * trick_values(suit, bid), 0}
  end

  def score(contract = %Bridge.Contract{suit: suit, bid: bid, doubled: true}, tricks_made) when tricks_made >= bid + 6 do
    {50 + overtrick_values(contract) * (tricks_made - bid - 6), 2 * trick_values(suit, bid), 0}
  end

  def score(contract = %Bridge.Contract{suit: suit, bid: bid}, tricks_made) when tricks_made >= bid + 6 do
    {overtrick_values(contract) * (tricks_made - bid - 6), trick_values(suit, bid), 0}
  end

  def score(contract = %Bridge.Contract{vulnerable: true, doubled: true}, tricks_made) do
    {0, 0, missed_by(contract, tricks_made) |> scaled(200, 300) }
  end

  def score(contract = %Bridge.Contract{vulnerable: true, redoubled: true}, tricks_made) do
    # scale: 100, 300, 500, 700
    {0, 0, missed_by(contract, tricks_made) |> scaled(400, 600) }
  end

  def score(contract = %Bridge.Contract{redoubled: true}, tricks_made) do
    # scale: 100, 300, 500, 700
    {0, 0, missed_by(contract, tricks_made) |> scaled(200, 400, 600) }
  end

  def score(contract = %Bridge.Contract{doubled: true}, tricks_made) do
    # scale: 100, 300, 500, 700
    {0, 0, missed_by(contract, tricks_made) |> scaled(100, 200, 300) }
  end

  def score(contract = %Bridge.Contract{vulnerable: true}, tricks_made) do
    {0, 0, missed_by(contract, tricks_made) * 100 }
  end

  def score(contract, tricks_made) do
    # scale: 50, 100, 150, ...
    {0, 0, missed_by(contract, tricks_made) * 50 }
  end

  defp missed_by(%Bridge.Contract{bid: bid}, tricks_made) when tricks_made < bid + 6 do
    bid + 6 - tricks_made
  end
  defp missed_by(_, _), do: 0

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