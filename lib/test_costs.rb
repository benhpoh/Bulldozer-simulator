require "minitest/autorun"
require "minitest/reporters"
require_relative "costs"

Minitest::Reporters.use!(Minitest::Reporters::SpecReporter.new)

class Init_Test < MiniTest::Test
  def test_read_commands
    cost = Cost.new(["a 3", "r", "a 1"], nil, nil)
    actual = cost.commands
    expected = ["a 3", "r", "a 1"]
    assert_equal(expected, actual)
  end

  def test_read_routes
    cost = Cost.new(nil, [["o","o","o"],["o"]], nil)
    actual = cost.routes
    expected = [["o","o","o"],["o"]]
    assert_equal(expected, actual)
  end
end

class Overhead_Test < MiniTest::Test
  def test_three_same_commands
    cost = Cost.new(["a", "a", "a"], nil, nil)
    actual = cost.overhead_cost
    expected = 3
    assert_equal(expected, actual)
  end

  def test_five_different_commands
    cost = Cost.new(["a", "r", "a 1", "l", "a 3"], nil, nil)
    actual = cost.overhead_cost
    expected = 5
    assert_equal(expected, actual)
  end

  def test_no_commands
    cost = Cost.new([], nil, nil)
    actual = cost.overhead_cost
    expected = 0
    assert_equal(expected, actual)
  end
end

class Fuel_Test < MiniTest::Test
  def test_one_route
    cost = Cost.new(nil, [["o","o","o"]], nil)
    actual = cost.fuel_cost
    expected = 3
    assert_equal(expected, actual)
  end

  def test_two_routes
    cost = Cost.new(nil, [["o","o","o"], ["o","o","o"]], nil)
    actual = cost.fuel_cost
    expected = 6
    assert_equal(expected, actual)
  end

  def test_cleared_cost
    cost = Cost.new(nil, [["-","-","-","-"]], nil)
    actual = cost.fuel_cost
    expected = 4
    assert_equal(expected, actual)
  end

  def test_rocks_cost
    cost = Cost.new(nil, [["r","r","r"]], nil)
    actual = cost.fuel_cost
    expected = 6
    assert_equal(expected, actual)
  end

  def test_trees_cost
    cost = Cost.new(nil, [["t","t"]], nil)
    actual = cost.fuel_cost
    expected = 4
    assert_equal(expected, actual)
  end
end

class Paint_Damage_Test < MiniTest::Test
  def test_no_trees
    cost = Cost.new(nil, [["o","o","o"]], nil)
    actual = cost.paint_damage
    expected = 0
    assert_equal(expected, actual)
  end

  def test_path_end_on_tree
    cost = Cost.new(nil, [["o","o","t"]], nil)
    actual = cost.paint_damage
    expected = 0
    assert_equal(expected, actual)
  end

  def test_path_through_tree
    cost = Cost.new(nil, [["o","t","o"]], nil)
    actual = cost.paint_damage
    expected = 1
    assert_equal(expected, actual)
  end

  def test_path_through_multiple_trees
    cost = Cost.new(nil, [["t","t","t"]], nil)
    actual = cost.paint_damage
    expected = 2
    assert_equal(expected, actual)
  end
end