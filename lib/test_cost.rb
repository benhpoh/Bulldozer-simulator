require "minitest/autorun"
require "minitest/reporters"
require_relative "cost"
require_relative "map"

Minitest::Reporters.use!(Minitest::Reporters::SpecReporter.new)

class Overhead_Test < MiniTest::Test
  def test_three_same_commands
    cost = Cost.new(["a", "a", "a"], nil, nil)
    actual = cost.overhead_quantity
    expected = 3
    assert_equal(expected, actual)
  end

  def test_five_different_commands
    cost = Cost.new(["a", "r", "a 1", "l", "a 3"], nil, nil)
    actual = cost.overhead_quantity
    expected = 5
    assert_equal(expected, actual)
  end

  def test_no_commands
    cost = Cost.new([], nil, nil)
    actual = cost.overhead_quantity
    expected = 0
    assert_equal(expected, actual)
  end
end

class Fuel_Test < MiniTest::Test
  def test_one_route
    cost = Cost.new(nil, Map.new([["o","o","o"]]).map_array, nil)
    actual = cost.fuel_quantity
    expected = 3
    assert_equal(expected, actual)
  end

  def test_two_routes
    cost = Cost.new(nil, Map.new([["o","o","o"], ["o","o","o"]]).map_array, nil)
    actual = cost.fuel_quantity
    expected = 6
    assert_equal(expected, actual)
  end

  def test_cleared_cost
    cost = Cost.new(nil, Map.new([["cleared","cleared","cleared","cleared"]]).map_array, nil)
    actual = cost.fuel_quantity
    expected = 4
    assert_equal(expected, actual)
  end

  def test_rocks_cost
    cost = Cost.new(nil, Map.new([["r","r","r"]]).map_array, nil)
    actual = cost.fuel_quantity
    expected = 6
    assert_equal(expected, actual)
  end

  def test_trees_cost
    cost = Cost.new(nil, Map.new([["t","t"]]).map_array, nil)
    actual = cost.fuel_quantity
    expected = 4
    assert_equal(expected, actual)
  end
end

class Paint_Damage_Test < MiniTest::Test
  def test_no_trees
    cost = Cost.new(nil, Map.new([["o","o","o"]]).map_array, nil)
    actual = cost.paint_damage
    expected = 0
    assert_equal(expected, actual)
  end

  def test_path_end_on_tree
    cost = Cost.new(nil, Map.new([["o","o","t"]]).map_array, nil)
    actual = cost.paint_damage
    expected = 0
    assert_equal(expected, actual)
  end

  def test_path_through_tree
    cost = Cost.new(nil, Map.new([["o","t","o"]]).map_array, nil)
    actual = cost.paint_damage
    expected = 1
    assert_equal(expected, actual)
  end

  def test_path_through_multiple_trees
    cost = Cost.new(nil, Map.new([["t","t","t"]]).map_array, nil)
    actual = cost.paint_damage
    expected = 2
    assert_equal(expected, actual)
  end
end

class Uncleared_Squares_Test < MiniTest::Test
  def test_fully_cleared
    cost = Cost.new(nil, nil, Map.new([["cleared","cleared","cleared"],["cleared","cleared","cleared"]]).map_array)
    actual = cost.uncleared_quantity
    expected = 0
    assert_equal(expected, actual)
  end
  
  def test_fully_cleared_with_protected_tree
    cost = Cost.new(nil, nil, Map.new([["cleared","cleared","cleared"],["cleared","cleared","T"]]).map_array)
    actual = cost.uncleared_quantity
    expected = 0
    assert_equal(expected, actual)
  end

  def test_partially_cleared_with_rocks
    cost = Cost.new(nil, nil, Map.new([["cleared","cleared","cleared"],["cleared","r","T"]]).map_array)
    actual = cost.uncleared_quantity
    expected = 1
    assert_equal(expected, actual)
  end
  
  def test_partially_cleared_with_removable_tree
    cost = Cost.new(nil, nil, Map.new([["cleared","cleared","cleared"],["cleared","t","T"]]).map_array)
    actual = cost.uncleared_quantity
    expected = 1
    assert_equal(expected, actual)
  end
  
  def test_partially_cleared_with_plains
    cost = Cost.new(nil, nil, Map.new([["cleared","cleared","cleared"],["cleared","o","T"]]).map_array)
    actual = cost.uncleared_quantity
    expected = 1
    assert_equal(expected, actual)
  end
  
  def test_partially_cleared_with_variety
    cost = Cost.new(nil, nil, Map.new([["cleared","cleared","t"],["r","o","T"]]).map_array)
    actual = cost.uncleared_quantity
    expected = 3
    assert_equal(expected, actual)
  end
  
  def test_uncleared
    cost = Cost.new(nil, nil, Map.new([["o","o","T"],["r","o","t"]]).map_array)
    actual = cost.uncleared_quantity
    expected = 5
    assert_equal(expected, actual)
  end
  
end

class Total_Cost_Test < MiniTest::Test
  def test_overall_costs
    cost = Cost.new(
      ["a 3", "r", "a", "r", "a 2"], 
      Map.new([["o","o","o"], ["o"], ["o","o"]]).map_array, 
      Map.new([["cleared","cleared","cleared"],["cleared","cleared","cleared"]]).map_array)
    actual = cost.calculate_total
    expected = [5, 6, 0, 0]
    assert_equal(expected, actual)
  end

  def test_overall_costs_uncleared
    cost = Cost.new(
      ["a 3", "r", "a", "r", "a 1"], 
      Map.new([["o","o","o"], ["o"], ["o"]]).map_array, 
      Map.new([["cleared","cleared","cleared"],["o","cleared","cleared"]]).map_array)
    actual = cost.calculate_total
    expected = [5, 5, 1, 0]
    assert_equal(expected, actual)
  end

end