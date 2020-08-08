require_relative "lib/input_validator"
require_relative "lib/command"
require_relative "lib/report"

InputValidator.validate_argument(ARGV)

site_map = File.read(ARGV[0]).split
site_map.map! { |row| row.split("") }
command = Command.new(site_map)

Report.display_welcome(site_map)

# Command input loop
while command.simulation_active
  print "(l)eft, (r)ight, (a)dvance <n>, (m)ap, (q)uit: "
  input = STDIN.gets.chomp
  response = command.execute(input)

  puts response[:error_description] if response[:error_raised?]
end

shutdown_data = response[:shutdown_data]

report = Report.new(
  shutdown_data[:commands],
  shutdown_data[:routes],
  shutdown_data[:end_map]
)

report.display_summary()