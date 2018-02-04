defmodule CalcTest do
  use ExUnit.Case
  doctest Calc

  test "Test Case 1" do
    assert Calc.eval("2 + 3 + 5") == 10.0
  end
  test "Test Case 2" do
    assert Calc.eval("2 + 3 - 5") == 0
  end
  test "Test Case 3" do
    assert Calc.eval("2 * ( 3 + 5 )") == 16
  end
  test "Test Case 4" do
    assert Calc.eval("24 / 6 + ( 5 - 4 )") == 5
  end
   test "Test Case 5" do
    assert Calc.eval("2.5 - 90") == - 87.5
  end
   test "Test Case 6" do
    assert Calc.eval("2*3 + 9*8 + 89") == 167
  end
  test "Test Case 7" do
    assert Calc.eval("2*3 + 9-8 + (89*12)") == 1075
  end
  test "Test Case 8" do
    assert Calc.eval("19 / 3 + 9-8 + (89*12)") == 1075.3333333333333
  end
  test "Test Case 9" do
    assert Calc.eval("2.5 + 2.6") == 5.1
  end
  test "Test Case 10" do
    assert Calc.eval("11-12 + (2*3) + 6") == 11
  end
end
