require "minitest/autorun"
require "minitest/reporters"
require_relative "bulldozer.rb"

Minitest::Reporters.use!(Minitest::Reporters::SpecReporter.new)

class LocationTest < MiniTest::Test
  def test_location_before_commands
    bulldozer = Bulldozer.new([["o","o","o"]])
    actual = bulldozer.location
    expected = "X - 0; Y - 1; Facing - East"
    assert_equal(expected, actual)
  end

  def test_location_after_advance_left
    bulldozer = Bulldozer.new([["o","o","o"]])
    bulldozer.advance(1)
    bulldozer.left
    actual = bulldozer.location
    expected = "X - 1; Y - 1; Facing - North"
    assert_equal(expected, actual)
  end

  def test_location_after_advance_3_right
    bulldozer = Bulldozer.new([["o","o","o"]])
    bulldozer.advance(3)
    bulldozer.right
    actual = bulldozer.location
    expected = "X - 3; Y - 1; Facing - South"
    assert_equal(expected, actual)
  end
end

class LeftTest < MiniTest::Test
  def test_left_once
    bulldozer = Bulldozer.new([["o","o","o"]])
    bulldozer.left
    actual = bulldozer.location
    expected = "X - 0; Y - 1; Facing - North"
    assert_equal(expected, actual)
  end

  def test_left_thrice
    bulldozer = Bulldozer.new([["o","o","o"]])
    3.times { bulldozer.left }
    actual = bulldozer.location
    expected = "X - 0; Y - 1; Facing - South"
    assert_equal(expected, actual)
  end

  def test_left_four_times
    bulldozer = Bulldozer.new([["o","o","o"]])
    4.times { bulldozer.left }
    actual = bulldozer.location
    expected = "X - 0; Y - 1; Facing - East"
    assert_equal(expected, actual)
  end

  def test_left_five_times
    bulldozer = Bulldozer.new([["o","o","o"]])
    5.times { bulldozer.left }
    actual = bulldozer.location
    expected = "X - 0; Y - 1; Facing - North"
    assert_equal(expected, actual)
  end
end

class RightTest < MiniTest::Test
  def test_right_once
    bulldozer = Bulldozer.new([["o","o","o"]])
    bulldozer.right
    actual = bulldozer.location
    expected = "X - 0; Y - 1; Facing - South"
    assert_equal(expected, actual)
  end

  def test_right_thrice
    bulldozer = Bulldozer.new([["o","o","o"]])
    3.times { bulldozer.right }
    actual = bulldozer.location
    expected = "X - 0; Y - 1; Facing - North"
    assert_equal(expected, actual)
  end

  def test_right_four_times
    bulldozer = Bulldozer.new([["o","o","o"]])
    4.times { bulldozer.right }
    actual = bulldozer.location
    expected = "X - 0; Y - 1; Facing - East"
    assert_equal(expected, actual)
  end

  def test_right_five_times
    bulldozer = Bulldozer.new([["o","o","o"]])
    5.times { bulldozer.right }
    actual = bulldozer.location
    expected = "X - 0; Y - 1; Facing - South"
    assert_equal(expected, actual)
  end
end

class HistoryTest < MiniTest::Test
  def test_history_at_initialization
    bulldozer = Bulldozer.new([["o","o","o"]])
    actual = bulldozer.history
    expected = "No commands issued"
    assert_equal(expected, actual)
  end

  def test_history_after_left
    bulldozer = Bulldozer.new([["o","o","o"]])
    bulldozer.left
    actual = bulldozer.history
    expected = "Turn left"
    assert_equal(expected, actual)
  end

  def test_history_after_left_twice
    bulldozer = Bulldozer.new([["o","o","o"]])
    2.times { bulldozer.left }
    actual = bulldozer.history
    expected = "Turn left, Turn left"
    assert_equal(expected, actual)
  end

  def test_history_after_right
    bulldozer = Bulldozer.new([["o","o","o"]])
    bulldozer.right
    actual = bulldozer.history
    expected = "Turn right"
    assert_equal(expected, actual)
  end

  def test_history_after_right_twice
    bulldozer = Bulldozer.new([["o","o","o"]])
    2.times { bulldozer.right }
    actual = bulldozer.history
    expected = "Turn right, Turn right"
    assert_equal(expected, actual)
  end

  def test_history_after_advance
    bulldozer = Bulldozer.new([["o","o","o"]])
    bulldozer.advance(1)
    actual = bulldozer.history
    expected = "Advance 1"
    assert_equal(expected, actual)
  end

  def test_history_after_advance_right_advance_left
    bulldozer = Bulldozer.new([["o","o","o"],["o","o","o"]])
    bulldozer.advance(1)
    bulldozer.right
    bulldozer.advance(1)
    bulldozer.left
    actual = bulldozer.history
    expected = "Advance 1, Turn right, Advance 1, Turn left"
    assert_equal(expected, actual)
  end

end

class AdvanceTest < MiniTest::Test
  def test_advance_without_argument
    bulldozer = Bulldozer.new([["o","o","o"]])
    bulldozer.advance
    actual = bulldozer.location
    expected = "X - 1; Y - 1; Facing - East"
    assert_equal(expected, actual)
  end

  def test_advance_onto_protected_tree
    skip
  end

  def test_advance_out_of_site
    skip
  end
end