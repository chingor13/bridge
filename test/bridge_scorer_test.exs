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

  test "overtricks minor suit" do
    for suit <- [:clubs, :diamonds] do
      assert {20, 20, 0} == Scorer.score(%Contract{suit: suit, bid: 1}, 8)
      assert {40, 20, 0} == Scorer.score(%Contract{suit: suit, bid: 1}, 9)
      assert {60, 20, 0} == Scorer.score(%Contract{suit: suit, bid: 1}, 10)
      assert {80, 20, 0} == Scorer.score(%Contract{suit: suit, bid: 1}, 11)
      assert {100, 20, 0} == Scorer.score(%Contract{suit: suit, bid: 1}, 12)
      assert {120, 20, 0} == Scorer.score(%Contract{suit: suit, bid: 1}, 13)
    end
  end

  test "made minor suit doubled" do
    for suit <- [:clubs, :diamonds] do
      assert {50, 40, 0} == Scorer.score(%Contract{suit: suit, bid: 1, doubled: true}, 7)
      assert {50, 80, 0} == Scorer.score(%Contract{suit: suit, bid: 2, doubled: true}, 8)
      assert {50, 120, 0} == Scorer.score(%Contract{suit: suit, bid: 3, doubled: true}, 9)
      assert {50, 160, 0} == Scorer.score(%Contract{suit: suit, bid: 4, doubled: true}, 10)
      assert {50, 200, 0} == Scorer.score(%Contract{suit: suit, bid: 5, doubled: true}, 11)
      assert {50, 240, 0} == Scorer.score(%Contract{suit: suit, bid: 6, doubled: true}, 12)
      assert {50, 280, 0} == Scorer.score(%Contract{suit: suit, bid: 7, doubled: true}, 13)
    end
  end

  test "overtricks minor suit doubled not-vulnerable" do
    for suit <- [:clubs, :diamonds] do
      assert {150, 40, 0} == Scorer.score(%Contract{suit: suit, bid: 1, doubled: true, vulnerable: false}, 8)
      assert {250, 40, 0} == Scorer.score(%Contract{suit: suit, bid: 1, doubled: true, vulnerable: false}, 9)
      assert {350, 40, 0} == Scorer.score(%Contract{suit: suit, bid: 1, doubled: true, vulnerable: false}, 10)
      assert {450, 40, 0} == Scorer.score(%Contract{suit: suit, bid: 1, doubled: true, vulnerable: false}, 11)
      assert {550, 40, 0} == Scorer.score(%Contract{suit: suit, bid: 1, doubled: true, vulnerable: false}, 12)
      assert {650, 40, 0} == Scorer.score(%Contract{suit: suit, bid: 1, doubled: true, vulnerable: false}, 13)
    end
  end

  test "overtricks minor suit doubled vulnerable" do
    for suit <- [:clubs, :diamonds] do
      assert {250, 40, 0} == Scorer.score(%Contract{suit: suit, bid: 1, doubled: true, vulnerable: true}, 8)
      assert {450, 40, 0} == Scorer.score(%Contract{suit: suit, bid: 1, doubled: true, vulnerable: true}, 9)
      assert {650, 40, 0} == Scorer.score(%Contract{suit: suit, bid: 1, doubled: true, vulnerable: true}, 10)
      assert {850, 40, 0} == Scorer.score(%Contract{suit: suit, bid: 1, doubled: true, vulnerable: true}, 11)
      assert {1050, 40, 0} == Scorer.score(%Contract{suit: suit, bid: 1, doubled: true, vulnerable: true}, 12)
      assert {1250, 40, 0} == Scorer.score(%Contract{suit: suit, bid: 1, doubled: true, vulnerable: true}, 13)
    end
  end

  test "made minor suit redoubled" do
    for suit <- [:clubs, :diamonds] do
      assert {100, 80, 0} == Scorer.score(%Contract{suit: suit, bid: 1, redoubled: true}, 7)
      assert {100, 160, 0} == Scorer.score(%Contract{suit: suit, bid: 2, redoubled: true}, 8)
      assert {100, 240, 0} == Scorer.score(%Contract{suit: suit, bid: 3, redoubled: true}, 9)
      assert {100, 320, 0} == Scorer.score(%Contract{suit: suit, bid: 4, redoubled: true}, 10)
      assert {100, 400, 0} == Scorer.score(%Contract{suit: suit, bid: 5, redoubled: true}, 11)
      assert {100, 480, 0} == Scorer.score(%Contract{suit: suit, bid: 6, redoubled: true}, 12)
      assert {100, 560, 0} == Scorer.score(%Contract{suit: suit, bid: 7, redoubled: true}, 13)
    end
  end

  test "overtricks minor suit redoubled not-vulnerable" do
    for suit <- [:clubs, :diamonds] do
      assert {300, 80, 0} == Scorer.score(%Contract{suit: suit, bid: 1, redoubled: true, vulnerable: false}, 8)
      assert {500, 80, 0} == Scorer.score(%Contract{suit: suit, bid: 1, redoubled: true, vulnerable: false}, 9)
      assert {700, 80, 0} == Scorer.score(%Contract{suit: suit, bid: 1, redoubled: true, vulnerable: false}, 10)
      assert {900, 80, 0} == Scorer.score(%Contract{suit: suit, bid: 1, redoubled: true, vulnerable: false}, 11)
      assert {1100, 80, 0} == Scorer.score(%Contract{suit: suit, bid: 1, redoubled: true, vulnerable: false}, 12)
      assert {1300, 80, 0} == Scorer.score(%Contract{suit: suit, bid: 1, redoubled: true, vulnerable: false}, 13)
    end
  end

  test "overtricks minor suit redoubled vulnerable" do
    for suit <- [:clubs, :diamonds] do
      assert {500, 80, 0} == Scorer.score(%Contract{suit: suit, bid: 1, redoubled: true, vulnerable: true}, 8)
      assert {900, 80, 0} == Scorer.score(%Contract{suit: suit, bid: 1, redoubled: true, vulnerable: true}, 9)
      assert {1300, 80, 0} == Scorer.score(%Contract{suit: suit, bid: 1, redoubled: true, vulnerable: true}, 10)
      assert {1700, 80, 0} == Scorer.score(%Contract{suit: suit, bid: 1, redoubled: true, vulnerable: true}, 11)
      assert {2100, 80, 0} == Scorer.score(%Contract{suit: suit, bid: 1, redoubled: true, vulnerable: true}, 12)
      assert {2500, 80, 0} == Scorer.score(%Contract{suit: suit, bid: 1, redoubled: true, vulnerable: true}, 13)
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

  test "made major suit doubled" do
    for suit <- [:hearts, :spades] do
      assert {50, 60, 0} == Scorer.score(%Contract{suit: suit, bid: 1, doubled: true}, 7)
      assert {50, 120, 0} == Scorer.score(%Contract{suit: suit, bid: 2, doubled: true}, 8)
      assert {50, 180, 0} == Scorer.score(%Contract{suit: suit, bid: 3, doubled: true}, 9)
      assert {50, 240, 0} == Scorer.score(%Contract{suit: suit, bid: 4, doubled: true}, 10)
      assert {50, 300, 0} == Scorer.score(%Contract{suit: suit, bid: 5, doubled: true}, 11)
      assert {50, 360, 0} == Scorer.score(%Contract{suit: suit, bid: 6, doubled: true}, 12)
      assert {50, 420, 0} == Scorer.score(%Contract{suit: suit, bid: 7, doubled: true}, 13)
    end
  end

  test "made major suit redoubled" do
    for suit <- [:hearts, :spades] do
      assert {100, 120, 0} == Scorer.score(%Contract{suit: suit, bid: 1, redoubled: true}, 7)
      assert {100, 240, 0} == Scorer.score(%Contract{suit: suit, bid: 2, redoubled: true}, 8)
      assert {100, 360, 0} == Scorer.score(%Contract{suit: suit, bid: 3, redoubled: true}, 9)
      assert {100, 480, 0} == Scorer.score(%Contract{suit: suit, bid: 4, redoubled: true}, 10)
      assert {100, 600, 0} == Scorer.score(%Contract{suit: suit, bid: 5, redoubled: true}, 11)
      assert {100, 720, 0} == Scorer.score(%Contract{suit: suit, bid: 6, redoubled: true}, 12)
      assert {100, 840, 0} == Scorer.score(%Contract{suit: suit, bid: 7, redoubled: true}, 13)
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

  test "made no trump doubled" do
    assert {50, 80, 0} == Scorer.score(%Contract{suit: :no_trump, bid: 1, doubled: true}, 7)
    assert {50, 140, 0} == Scorer.score(%Contract{suit: :no_trump, bid: 2, doubled: true}, 8)
    assert {50, 200, 0} == Scorer.score(%Contract{suit: :no_trump, bid: 3, doubled: true}, 9)
    assert {50, 260, 0} == Scorer.score(%Contract{suit: :no_trump, bid: 4, doubled: true}, 10)
    assert {50, 320, 0} == Scorer.score(%Contract{suit: :no_trump, bid: 5, doubled: true}, 11)
    assert {50, 380, 0} == Scorer.score(%Contract{suit: :no_trump, bid: 6, doubled: true}, 12)
    assert {50, 440, 0} == Scorer.score(%Contract{suit: :no_trump, bid: 7, doubled: true}, 13)
  end

  test "made no trump redoubled" do
    assert {100, 160, 0} == Scorer.score(%Contract{suit: :no_trump, bid: 1, redoubled: true}, 7)
    assert {100, 280, 0} == Scorer.score(%Contract{suit: :no_trump, bid: 2, redoubled: true}, 8)
    assert {100, 400, 0} == Scorer.score(%Contract{suit: :no_trump, bid: 3, redoubled: true}, 9)
    assert {100, 520, 0} == Scorer.score(%Contract{suit: :no_trump, bid: 4, redoubled: true}, 10)
    assert {100, 640, 0} == Scorer.score(%Contract{suit: :no_trump, bid: 5, redoubled: true}, 11)
    assert {100, 760, 0} == Scorer.score(%Contract{suit: :no_trump, bid: 6, redoubled: true}, 12)
    assert {100, 880, 0} == Scorer.score(%Contract{suit: :no_trump, bid: 7, redoubled: true}, 13)
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

  test "missed vulnerable contracts" do
    for suit <- [:club, :diamonds, :hearts, :spades, :no_trump] do
      assert {0, 0, 100} == Scorer.score(%Contract{suit: suit, bid: 1, vulnerable: true}, 6)
      assert {0, 0, 200} == Scorer.score(%Contract{suit: suit, bid: 2, vulnerable: true}, 6)
      assert {0, 0, 300} == Scorer.score(%Contract{suit: suit, bid: 3, vulnerable: true}, 6)
      assert {0, 0, 400} == Scorer.score(%Contract{suit: suit, bid: 4, vulnerable: true}, 6)
      assert {0, 0, 500} == Scorer.score(%Contract{suit: suit, bid: 5, vulnerable: true}, 6)
      assert {0, 0, 600} == Scorer.score(%Contract{suit: suit, bid: 6, vulnerable: true}, 6)
      assert {0, 0, 700} == Scorer.score(%Contract{suit: suit, bid: 7, vulnerable: true}, 6)
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

  test "missed doubled vulnerable contracts" do
    for suit <- [:club, :diamonds, :hearts, :spades, :no_trump] do
      assert {0, 0, 200} == Scorer.score(%Contract{suit: suit, bid: 1, doubled: true, vulnerable: true}, 6)
      assert {0, 0, 500} == Scorer.score(%Contract{suit: suit, bid: 2, doubled: true, vulnerable: true}, 6)
      assert {0, 0, 800} == Scorer.score(%Contract{suit: suit, bid: 3, doubled: true, vulnerable: true}, 6)
      assert {0, 0, 1100} == Scorer.score(%Contract{suit: suit, bid: 4, doubled: true, vulnerable: true}, 6)
      assert {0, 0, 1400} == Scorer.score(%Contract{suit: suit, bid: 5, doubled: true, vulnerable: true}, 6)
      assert {0, 0, 1700} == Scorer.score(%Contract{suit: suit, bid: 6, doubled: true, vulnerable: true}, 6)
      assert {0, 0, 2000} == Scorer.score(%Contract{suit: suit, bid: 7, doubled: true, vulnerable: true}, 6)
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

  test "missed redoubled vulnerable contracts" do
    for suit <- [:club, :diamonds, :hearts, :spades, :no_trump] do
      assert {0, 0, 400} == Scorer.score(%Contract{suit: suit, bid: 1, redoubled: true, vulnerable: true}, 6)
      assert {0, 0, 1000} == Scorer.score(%Contract{suit: suit, bid: 2, redoubled: true, vulnerable: true}, 6)
      assert {0, 0, 1600} == Scorer.score(%Contract{suit: suit, bid: 3, redoubled: true, vulnerable: true}, 6)
      assert {0, 0, 2200} == Scorer.score(%Contract{suit: suit, bid: 4, redoubled: true, vulnerable: true}, 6)
      assert {0, 0, 2800} == Scorer.score(%Contract{suit: suit, bid: 5, redoubled: true, vulnerable: true}, 6)
      assert {0, 0, 3400} == Scorer.score(%Contract{suit: suit, bid: 6, redoubled: true, vulnerable: true}, 6)
      assert {0, 0, 4000} == Scorer.score(%Contract{suit: suit, bid: 7, redoubled: true, vulnerable: true}, 6)
    end
  end

end
