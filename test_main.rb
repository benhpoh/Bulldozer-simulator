require "minitest/autorun"
require "minitest/reporters"

Minitest::Reporters.use!(Minitest::Reporters::SpecReporter.new)

class LocationTest < MiniTest::Test
  def test_location_before_commands
    # assert_equal nil, location()
  end

  def test_location_after_advance_once_command
    # assert_equal "X - 0; Y - 0; Facing - East", advance(1).location()
  end
end