require_relative "lib/check_input"
require_relative "lib/command"
require_relative "lib/bulldozer"
require_relative "lib/map"

CheckInput.new(ARGV)
puts "File check passed.\n "

site_map = File.read(ARGV[0]).split
site_map.map! { |row| row.split("") }
command = Command.new(site_map)

puts "Welcome to the Aconex site clearing simulator. This is a map of the site:\n "

puts site_map.map { |row| row.map(&:symbol).join(" ") }

puts "\nThe bulldozer is currently located at the Northern edge of the site, immediately to the West of the site, and facing East.\n "

simulation_ended_because = nil
protected_tree_damaged = 0

print "(l)eft, (r)ight, (a)dvance <n>, (m)ap, (q)uit: "
input = STDIN.gets.chomp

while command.simulation_active
  response = command.execute(input)

  if response[:error_raised?] # Error raised
    puts response[:error_description]

    if response[:error_description] == "Error, invalid command."
      print "(l)eft, (r)ight, (a)dvance <n>, (m)ap, (q)uit: "
      input = STDIN.gets.chomp
    end

  else # No error. Loop for next command
    print "(l)eft, (r)ight, (a)dvance <n>, (m)ap, (q)uit: "
    input = STDIN.gets.chomp
  end

end # Simulation ended

puts command.commands_history.join(", ")
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

output.each do |line|
  puts line[0].ljust(34) + line[1].to_s.rjust(8) + line[2].to_s.rjust(8)
end

puts "-----"
puts "Total" + total_cost.to_s.rjust(45) + "\n "

puts "Thank you for using the Aconex site clearing simulator.\n "
puts "Built with <3 by Ben"