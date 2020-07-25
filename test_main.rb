require "minitest/autorun"
require "minitest/reporters"
require_relative "main.rb"

Minitest::Reporters.use!(Minitest::Reporters::SpecReporter.new)

class LocationTest < MiniTest::Test
  def test_location_before_commands
    bulldozer = Bulldozer.new()
    actual = bulldozer.location
    expected = "X - 0; Y - 1; Facing - East"
    assert_equal(expected, actual)
  end

  def test_location_after_advance_once_command
    skip #assert_equal(expected, actual)
  end
end

class LeftTest < MiniTest::Test
  def test_left_once
    bulldozer = Bulldozer.new()
    bulldozer.left
    actual = bulldozer.location
    expected = "X - 0; Y - 1; Facing - North"
    assert_equal(expected, actual)
  end

  def test_left_thrice
    bulldozer = Bulldozer.new()
    3.times { bulldozer.left }
    actual = bulldozer.location
    expected = "X - 0; Y - 1; Facing - South"
    assert_equal(expected, actual)
  end

  def test_left_four_times
    bulldozer = Bulldozer.new()
    4.times { bulldozer.left }
    actual = bulldozer.location
    expected = "X - 0; Y - 1; Facing - East"
    assert_equal(expected, actual)
  end

  def test_left_five_times
    bulldozer = Bulldozer.new()
    5.times { bulldozer.left }
    actual = bulldozer.location
    expected = "X - 0; Y - 1; Facing - North"
    assert_equal(expected, actual)
  end
end

class RightTest < MiniTest::Test
  def test_right_once
    bulldozer = Bulldozer.new()
    bulldozer.right
    actual = bulldozer.location
    expected = "X - 0; Y - 1; Facing - South"
    assert_equal(expected, actual)
  end

  def test_right_thrice
    bulldozer = Bulldozer.new()
    3.times { bulldozer.right }
    actual = bulldozer.location
    expected = "X - 0; Y - 1; Facing - North"
    assert_equal(expected, actual)
  end

  def test_right_four_times
    bulldozer = Bulldozer.new()
    4.times { bulldozer.right }
    actual = bulldozer.location
    expected = "X - 0; Y - 1; Facing - East"
    assert_equal(expected, actual)
  end

  def test_right_five_times
    bulldozer = Bulldozer.new()
    5.times { bulldozer.right }
    actual = bulldozer.location
    expected = "X - 0; Y - 1; Facing - South"
    assert_equal(expected, actual)
  end
end