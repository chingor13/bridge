defmodule Bridge.Contract do
  defstruct suit: "", bid: 1, doubled: false, redoubled: false, vulnerable: false

  def is_minor?(%Bridge.Contract{suit: :clubs}), do: true
  def is_minor?(%Bridge.Contract{suit: :diamonds}), do: true
  def is_minor?(_), do: false
end