require "minitest/autorun"
require "minitest/reporters"
require_relative "costs"

Minitest::Reporters.use!(Minitest::Reporters::SpecReporter.new)

class Init_Test < MiniTest::Test
  def test_read_commands
    cost = Cost.new(["a 3", "r", "a 1"], nil)
    actual = cost.commands
    expected = ["a 3", "r", "a 1"]
    assert_equal(expected, actual)
  end

  def test_read_routes
    cost = Cost.new(nil, [["o","o","o"],["o"]])
    actual = cost.routes
    expected = [["o","o","o"],["o"]]
    assert_equal(expected, actual)
  end
end

class Overhead_Test < MiniTest::Test
  def test_three_same_commands
    cost = Cost.new(["a", "a", "a"], nil)
    actual = cost.overhead_cost
    expected = 3
    assert_equal(expected, actual)
  end

  def test_five_different_commands
    cost = Cost.new(["a", "r", "a 1", "l", "a 3"], nil)
    actual = cost.overhead_cost
    expected = 5
    assert_equal(expected, actual)
  end

  def test_no_commands
    cost = Cost.new([], nil)
    actual = cost.overhead_cost
    expected = 0
    assert_equal(expected, actual)
  end
end

class Fuel_Test < MiniTest::Test
  def test_one_route
    cost = Cost.new(nil, [["o","o","o"]])
    actual = cost.fuel_cost
    expected = 3
    assert_equal(expected, actual)
  end

  def test_two_routes
    cost = Cost.new(nil, [["o","o","o"], ["o","o","o"]])
    actual = cost.fuel_cost
    expected = 6
    assert_equal(expected, actual)
  end

  def test_cleared_cost
    cost = Cost.new(nil, [["-","-","-","-"]])
    actual = cost.fuel_cost
    expected = 4
    assert_equal(expected, actual)
  end

  def test_rocks_cost
    cost = Cost.new(nil, [["r","r","r"]])
    actual = cost.fuel_cost
    expected = 6
    assert_equal(expected, actual)
  end

  def test_trees_cost
    cost = Cost.new(nil, [["t","t"]])
    actual = cost.fuel_cost
    expected = 4
    assert_equal(expected, actual)
  end
end
