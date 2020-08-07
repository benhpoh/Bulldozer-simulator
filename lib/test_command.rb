require "minitest/autorun"
require "minitest/reporters"
require_relative "command"

Minitest::Reporters.use!(Minitest::Reporters::SpecReporter.new)

class Init_Test < MiniTest::Test
  def test_read_commands
    command = Command.new([["o","o","o"]])
    actual = command.commands_history
    expected = []
    assert_equal(expected, actual)
  end

  def test_simulation_active
    command = Command.new([["o","o","o"]])
    actual = command.simulation_active
    expected = true
    assert_equal(expected, actual)
  end
end

class Simulation_Active_Test < MiniTest::Test
  def test_quit_command
    command = Command.new([["o","o","o"]])
    command.execute("q")
    actual = command.simulation_active
    expected = false
    assert_equal(expected, actual)
  end

  def test_exit_site
    command = Command.new([["o","o","o"]])
    command.execute("a 4")
    actual = command.simulation_active
    expected = false
    assert_equal(expected, actual)
  end

  def test_hitting_protected_tree
    command = Command.new([["o","o","T"]])
    command.execute("a 3")
    actual = command.simulation_active
    expected = false
    assert_equal(expected, actual)
  end

end

class Response_Test < MiniTest::Test
  def test_invalid_command
    command = Command.new([["o","o","o"]])
    response = command.execute("x")
    actual = response[:error_description]
    expected = "Error, invalid command."
    assert_equal(expected, actual)
  end

  def test_error_raised
    command = Command.new([["o","o","o"]])
    response = command.execute("x")
    actual = response[:error_raised?]
    expected = true
    assert_equal(expected, actual)
  end

  def test_invalid_followed_by_valid_command
    command = Command.new([["o","o","o"]])
    response = command.execute("x")
    response = command.execute("a")
    actual = response[:error_raised?]
    expected = false
    assert_equal(expected, actual)
  end
  
  def test_valid_command
    command = Command.new([["o","o","o"]])
    response = command.execute("a")
    actual = response[:error_description]
    expected = nil
    assert_equal(expected, actual)
  end

  def test_series_of_valid_commands
    command = Command.new([["o","o","o"]])
    response = command.execute("a")
    response = command.execute("a")
    response = command.execute("r")
    actual = response[:error_description]
    expected = nil
    assert_equal(expected, actual)
  end

  def test_advancing_to_tree
    command = Command.new([["o","o","T"]])
    response = command.execute("a 3")
    actual = response[:error_description]
    expected = "\nThe simulation has ended due to an attempt to remove a protected tree. These are the commands you issued:\n "
    assert_equal(expected, actual)
  end

  def test_advancing_off_site
    command = Command.new([["o","o","o"]])
    response = command.execute("a 5")
    actual = response[:error_description]
    expected = "\nThe simulation has ended due to an attempt to exit the site boundaries. These are the commands you issued:\n "
    assert_equal(expected, actual)
  end
end

class Commands_History_Test < MiniTest::Test
  def test_single_command
    command = Command.new([["o","o","o"]])
    response = command.execute("a")
    actual = command.commands_history
    expected = ["Advance 1"]
    assert_equal(expected, actual)
  end

  def test_multiple_commands
    command = Command.new([["o","o","o"]])
    response = command.execute("a")
    response = command.execute("l")
    response = command.execute("r")
    response = command.execute("a 2")
    response = command.execute("m")
    response = command.execute("q")
    actual = command.commands_history
    expected = ["Advance 1", "Turn left", "Turn right", "Advance 2"]
    assert_equal(expected, actual)
  end

  def test_commands_after_quit
    command = Command.new([["o","o","o"]])
    response = command.execute("a")
    response = command.execute("l")
    response = command.execute("r")
    response = command.execute("q")
    response = command.execute("a 2")
    response = command.execute("m")
    actual = command.commands_history
    expected = ["Advance 1", "Turn left", "Turn right"]
    assert_equal(expected, actual)
  end

  def test_commands_after_illegal_command
    command = Command.new([["o","o","o"]])
    response = command.execute("a 4")
    response = command.execute("l")
    response = command.execute("r")
    response = command.execute("q")
    response = command.execute("a 2")
    response = command.execute("m")
    actual = command.commands_history
    expected = ["Advance 4"]
    assert_equal(expected, actual)
  end
end