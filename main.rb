require_relative "lib/check_file"
require_relative "lib/bulldozer"
require_relative "lib/map"

check_file()
puts "File check passed.\n "

site_map = File.read(ARGV[0]).split
site_map.map! { |row| row.split("") }

puts "Welcome to the Aconex site clearing simulator. This is a map of the site:\n "

puts site_map.map { |row| row.join(" ") }
# Immutable map method for CLI display only

bulldozer = Bulldozer.new(site_map)

puts "The bulldozer is currently located at the Northern edge of the site, immediately to the West of the site, and facing East.\n "

print "(l)eft, (r)ight, (a)dvance <n>, (m)ap, (q)uit: "
command = STDIN.gets.chomp

simulation_active = true
simulation_ended_because = nil

while simulation_active
  response = bulldozer.execute(command)

  if response[0] == false # Error raised
    case response[1] # Error code
      when "T"
        simulation_active = false
        simulation_ended_because = "tree"
      when "OUT"
        simulation_active = false
        simulation_ended_because = "out"
      else
        puts "Error, invalid command."
        print "(l)eft, (r)ight, (a)dvance <n>, (m)ap, (q)uit: "
        command = STDIN.gets.chomp
    end
  end

  if command == "q" # Simulation ended by user
    simulation_active = false
    simulation_ended_because = "user"
  end
end