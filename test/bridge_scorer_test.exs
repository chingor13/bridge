defmodule BridgeScorerTest do
  use ExUnit.Case
  doctest Bridge.Scorer

  alias Bridge.Scorer
  alias Bridge.Contract

  test "made minor suit" do
    for suit <- [:clubs, :diamonds] do 
      assert {0, 20, 0} == Scorer.score(%Contract{suit: suit, bid: 1}, 7)
      assert {0, 40, 0} == Scorer.score(%Contract{suit: suit, bid: 2}, 8)
      assert {0, 60, 0} == Scorer.score(%Contract{suit: suit, bid: 3}, 9)
      assert {0, 80, 0} == Scorer.score(%Contract{suit: suit, bid: 4}, 10)
      assert {0, 100, 0} == Scorer.score(%Contract{suit: suit, bid: 5}, 11)
      assert {0, 120, 0} == Scorer.score(%Contract{suit: suit, bid: 6}, 12)
      assert {0, 140, 0} == Scorer.score(%Contract{suit: suit, bid: 7}, 13)
    end
  end

  test "made major suit" do
    for suit <- [:hearts, :spades] do 
      assert {0, 30, 0} == Scorer.score(%Contract{suit: suit, bid: 1}, 7)
      assert {0, 60, 0} == Scorer.score(%Contract{suit: suit, bid: 2}, 8)
      assert {0, 90, 0} == Scorer.score(%Contract{suit: suit, bid: 3}, 9)
      assert {0, 120, 0} == Scorer.score(%Contract{suit: suit, bid: 4}, 10)
      assert {0, 150, 0} == Scorer.score(%Contract{suit: suit, bid: 5}, 11)
      assert {0, 180, 0} == Scorer.score(%Contract{suit: suit, bid: 6}, 12)
      assert {0, 210, 0} == Scorer.score(%Contract{suit: suit, bid: 7}, 13)
    end
  end

  test "made no trump" do
    assert {0, 40, 0} == Scorer.score(%Contract{suit: :no_trump, bid: 1}, 7)
    assert {0, 70, 0} == Scorer.score(%Contract{suit: :no_trump, bid: 2}, 8)
    assert {0, 100, 0} == Scorer.score(%Contract{suit: :no_trump, bid: 3}, 9)
    assert {0, 130, 0} == Scorer.score(%Contract{suit: :no_trump, bid: 4}, 10)
    assert {0, 160, 0} == Scorer.score(%Contract{suit: :no_trump, bid: 5}, 11)
    assert {0, 190, 0} == Scorer.score(%Contract{suit: :no_trump, bid: 6}, 12)
    assert {0, 220, 0} == Scorer.score(%Contract{suit: :no_trump, bid: 7}, 13)
  end

  test "missed contracts" do
    for suit <- [:club, :diamonds, :hearts, :spades, :no_trump] do
      assert {0, 0, 50} == Scorer.score(%Contract{suit: suit, bid: 1}, 6)
      assert {0, 0, 100} == Scorer.score(%Contract{suit: suit, bid: 2}, 6)
      assert {0, 0, 150} == Scorer.score(%Contract{suit: suit, bid: 3}, 6)
      assert {0, 0, 200} == Scorer.score(%Contract{suit: suit, bid: 4}, 6)
      assert {0, 0, 250} == Scorer.score(%Contract{suit: suit, bid: 5}, 6)
      assert {0, 0, 300} == Scorer.score(%Contract{suit: suit, bid: 6}, 6)
      assert {0, 0, 350} == Scorer.score(%Contract{suit: suit, bid: 7}, 6)
    end
  end

  test "missed doubled contracts" do
    for suit <- [:club, :diamonds, :hearts, :spades, :no_trump] do
      assert {0, 0, 100} == Scorer.score(%Contract{suit: suit, bid: 1, doubled: true}, 6)
      assert {0, 0, 300} == Scorer.score(%Contract{suit: suit, bid: 2, doubled: true}, 6)
      assert {0, 0, 500} == Scorer.score(%Contract{suit: suit, bid: 3, doubled: true}, 6)
      assert {0, 0, 800} == Scorer.score(%Contract{suit: suit, bid: 4, doubled: true}, 6)
      assert {0, 0, 1100} == Scorer.score(%Contract{suit: suit, bid: 5, doubled: true}, 6)
      assert {0, 0, 1400} == Scorer.score(%Contract{suit: suit, bid: 6, doubled: true}, 6)
      assert {0, 0, 1700} == Scorer.score(%Contract{suit: suit, bid: 7, doubled: true}, 6)
    end
  end

  test "missed redoubled contracts" do
    for suit <- [:club, :diamonds, :hearts, :spades, :no_trump] do
      assert {0, 0, 200} == Scorer.score(%Contract{suit: suit, bid: 1, redoubled: true}, 6)
      assert {0, 0, 600} == Scorer.score(%Contract{suit: suit, bid: 2, redoubled: true}, 6)
      assert {0, 0, 1000} == Scorer.score(%Contract{suit: suit, bid: 3, redoubled: true}, 6)
      assert {0, 0, 1600} == Scorer.score(%Contract{suit: suit, bid: 4, redoubled: true}, 6)
      assert {0, 0, 2200} == Scorer.score(%Contract{suit: suit, bid: 5, redoubled: true}, 6)
      assert {0, 0, 2800} == Scorer.score(%Contract{suit: suit, bid: 6, redoubled: true}, 6)
      assert {0, 0, 3400} == Scorer.score(%Contract{suit: suit, bid: 7, redoubled: true}, 6)
    end
  end

end
