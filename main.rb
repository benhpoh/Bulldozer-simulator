require_relative "lib/check_file"
require_relative "lib/bulldozer"
require_relative "lib/map"

check_file()
puts "File check passed.\n "

site_map = File.read(ARGV[0]).split
site_map.map! { |row| row.split("") } ##### I WOULD HAVE A BANG HERE BUT MAKE ANOTHER VARIABLE INSTEAD ########

puts "Welcome to the Aconex site clearing simulator. This is a map of the site:\n "

puts site_map.map { |row| row.join(" ") }
# Immutable map method for CLI display only

bulldozer = Bulldozer.new(site_map)

puts "\nThe bulldozer is currently located at the Northern edge of the site, immediately to the West of the site, and facing East.\n "

simulation_active = true
simulation_ended_because = nil
protected_tree_damaged = 0

print "(l)eft, (r)ight, (a)dvance <n>, (m)ap, (q)uit: "
command = STDIN.gets.chomp

while simulation_active
  response = bulldozer.execute(command)

  #### the two line below could be clearer => what is response[0] and what is response[1], can you name them ######
  # now reading, i think you can better this section. a simple way would be name variable
  has_error = response[0] == false
  error_code = response[1]

  if has_error
    case error_code
      when "T"
        simulation_active = false
        protected_tree_damaged += 1
        simulation_ended_because = "The simulation has ended due to an attempt to remove a protected tree. These are the commands you issued:"
      when "OUT"
        simulation_active = false
        simulation_ended_because = "The simulation has ended due to an attempt to exit the site boundaries. These are the commands you issued:"
      when "QUIT"
        simulation_active = false
        simulation_ended_because = "The simulation has ended at your request. These are the commands you issued:"
      else
        puts "Error, invalid command."
        print "(l)eft, (r)ight, (a)dvance <n>, (m)ap, (q)uit: "
        command = STDIN.gets.chomp
    end

  else # No error. Loop for next command
    print "(l)eft, (r)ight, (a)dvance <n>, (m)ap, (q)uit: "
    command = STDIN.gets.chomp
  end

end # Simulation ended

puts "\n"

puts simulation_ended_because
puts "\n"

puts bulldozer.history
puts "\n"

# --------------------------------------#
# Calculate total costs prior to output #
# --------------------------------------#

overhead_quantity, fuel_quantity, uncleared_quantity, paint_damage = bulldozer.cost

costs = {
  overhead: 1,
  fuel: 1,
  uncleared: 3,
  protected_tree: 10,
  paint_damage: 2
}

output = [
  ["Item", "Quantity", "Cost"],
  ["Communication overhead", overhead_quantity, overhead_quantity * 1],
  ["Fuel usage", fuel_quantity, fuel_quantity * costs[:fuel]],
  ["Uncleared squares", uncleared_quantity, uncleared_quantity * costs[:uncleared]],
  ["Destruction of protected tree", protected_tree_damaged, protected_tree_damaged * costs[:protected_tree]],
  ["Paint damage to bulldozer", paint_damage, paint_damage * costs[:paint_damage]],
]

total_cost = 0

output
  .slice(1..-1) # Disregard header row
  .each { |line| total_cost += line[2] }

# --------------------------------------

puts "The costs for this land clearing operation were:\n "

####### Can you wrapped this in a function and give it a name? #######
# it feels like a punch in the face when you get to this line, it's too low level
output.each do |line|
  puts line[0].ljust(34) + line[1].to_s.rjust(8) + line[2].to_s.rjust(8)
end

puts "-----"
puts "Total" + total_cost.to_s.rjust(45) + "\n "

puts "Thank you for using the Aconex site clearing simulator.\n "
puts "Built with <3 by Ben"