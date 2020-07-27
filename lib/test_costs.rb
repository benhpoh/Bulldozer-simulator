require "minitest/autorun"
require "minitest/reporters"
require_relative "costs"

Minitest::Reporters.use!(Minitest::Reporters::SpecReporter.new)

class Outside_Site_Test < MiniTest::Test
  def test_read_commands
    cost = Cost.new ["a 3", "r", "a 1"], nil
    actual = cost.commands
    expected = ["a 3", "r", "a 1"]
    assert_equal(expected, actual)
  end

  def test_read_routes
    cost = Cost.new nil, [["o","o","o"],["o"]]
    actual = cost.routes
    expected = [["o","o","o"],["o"]]
    assert_equal(expected, actual)
  end
end