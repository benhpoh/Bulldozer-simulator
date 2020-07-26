require_relative "lib/check_file"
require_relative "lib/bulldozer"
require_relative "lib/map"

check_file()
puts "File check passed.\n "

site_map = File.read(ARGV[0]).split
site_map.map! { |row| row.split("") }

puts "Welcome to the Aconex site clearing simulator. This is a map of the site:\n "

puts site_map.map { |row| row.join(" ") }

bulldozer = Bulldozer.new

puts "The bulldozer is currently located at the Northern edge of the site, immediately to the West of the site, and facing East.\n "

print "(l)eft, (r)ight, (a)dvance <n>, (lo)cation, (q)uit: "
command = STDIN.gets.chomp

while command != "q"
  response = bulldozer.execute(command)
  if response == false
    puts "Error. Invalid command."
  end
  print "(l)eft, (r)ight, (a)dvance <n>, (lo)cation, (q)uit: "
  command = STDIN.gets.chomp
end