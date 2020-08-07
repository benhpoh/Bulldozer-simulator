require_relative "lib/check_input"
require_relative "lib/command"
require_relative "lib/bulldozer"
require_relative "lib/map"
require_relative "lib/output"

CheckInput.new(ARGV)
puts "Filetype check passed.\n "

site_map = File.read(ARGV[0]).split
site_map.map! { |row| row.split("") }
command = Command.new(site_map)

Output.new(nil, nil, site_map).welcome

# Command input loop
while command.simulation_active
  print "(l)eft, (r)ight, (a)dvance <n>, (m)ap, (q)uit: "
  
  input = STDIN.gets.chomp
  response = command.execute(input)

  puts response[:error_description] if response[:error_raised?]
end

shutdown_data = response[:shutdown_data]

output = Output.new(
  shutdown_data[:commands],
  shutdown_data[:routes],
  shutdown_data[:end_map]
)

output.commands_issued()

output.cost_table()

output.footer()