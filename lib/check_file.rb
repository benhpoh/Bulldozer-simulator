def check_file
  if ARGV.length < 1
    puts "Missing map file. Run process again with the map file as a value after 'main.rb'"
    exit
  elsif ARGV.length > 1
    puts "Too many values. Run process again with only the map file as value after 'main.rb'"
    exit
  end
  
  if ARGV[0].slice(-4..-1) != ".txt"
    puts "Invalid file format. Expecting '.txt'"
    exit
  end
end
