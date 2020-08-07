require "minitest/autorun"
require "minitest/reporters"
require_relative "map"

Minitest::Reporters.use!(Minitest::Reporters::SpecReporter.new)

class Within_Site_Test < MiniTest::Test
  def test_within_site_0_0
    map = Map.new [["o","o","o"], ["o","o","o"], ["o","o","o"]]
    actual = map.within_site?(0,0)
    expected = true
    assert_equal(expected, actual)
  end

  def test_within_site_2_2
    map = Map.new [["o","o","o"], ["o","o","o"], ["o","o","o"]]
    actual = map.within_site?(2,2)
    expected = true
    assert_equal(expected, actual)
  end

  def test_outside_site_neg1_0
    map = Map.new [["o","o","o"], ["o","o","o"], ["o","o","o"]]
    actual = map.within_site?(-1,0)
    expected = false
    assert_equal(expected, actual)
  end

  def test_outside_site_0_neg1
    map = Map.new [["o","o","o"], ["o","o","o"], ["o","o","o"]]
    actual = map.within_site?(0,-1)
    expected = false
    assert_equal(expected, actual)
  end

  def test_outside_site_1_3
    map = Map.new [["o","o","o"], ["o","o","o"], ["o","o","o"]]
    actual = map.within_site?(1,3)
    expected = false
    assert_equal(expected, actual)
  end
end

class Can_Be_Cleared_Test < MiniTest::Test
  def test_protected_tree
    map = Map.new [["T","o","o"]]
    actual = map.can_be_cleared?(0,0)
    expected = false
    assert_equal(expected, actual)
  end

  def test_removable_tree
    map = Map.new [["t","o","o"]]
    actual = map.can_be_cleared?(0,0)
    expected = true
    assert_equal(expected, actual)
  end

  def test_rocky_land
    map = Map.new [["r","o","o"]]
    actual = map.can_be_cleared?(0,0)
    expected = true
    assert_equal(expected, actual)
  end

  def test_plain_land
    map = Map.new [["o","o","o"]]
    actual = map.can_be_cleared?(0,0)
    expected = true
    assert_equal(expected, actual)
  end

  def test_cleared_land
    map = Map.new [["cleared","o","o"]]
    actual = map.can_be_cleared?(0,0)
    expected = true
    assert_equal(expected, actual)
  end

  def test_outside_site
    map = Map.new [["o","o","o"]]
    actual = map.can_be_cleared?(0,3)
    expected = false
    assert_equal(expected, actual)
  end
end
