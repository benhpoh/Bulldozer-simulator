class InputValidator
  def self.validate_argument(input)
    check_arguments_length(input)
    check_file_type(input)
    puts "Filetype check passed.\n "
  end
  
  private

  def self.check_file_type(input)
    if input[0].slice(-4..-1) != ".txt"
      puts "Invalid file format. Expecting '.txt'"
      exit
    end
  end
  
  def self.check_arguments_length(input)
    if input.length < 1
      puts "Missing map file. Run process again with the map file as a value after 'main.rb'"
      exit
    elsif input.length > 1
      puts "Too many values. Run process again with only the map file as value after 'main.rb'"
      exit
    end
  end
end
