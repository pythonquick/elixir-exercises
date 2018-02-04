defmodule StatsPropertyTest do
  use ExUnit.Case
  use ExCheck

  describe "Stats on lists of ints" do
    property "single element lists are their own sum" do
      for_all number in real() do
        Stats.sum([number]) == number
      end
    end

    property "count not negative" do
      for_all l in list(int) do
        Stats.count(l) >= 0
      end
    end

    property "sum equals average times count" do
      for_all l in such_that(l in list(int) when length(l) > 0) do
          abs(Stats.sum(l) - Stats.average(l) * Stats.count(l)) < 0.1
      end
    end
  end
end
