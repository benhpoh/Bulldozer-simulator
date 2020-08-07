class CheckInput
  def initialize(input)
    check_input(input)
  end
  
  private

  def check_input(input)
    check_arguments_length(input)
    check_file_type(input)
    puts "Filetype check passed.\n "
  end

  def check_file_type(input)
    if input[0].slice(-4..-1) != ".txt"
      puts "Invalid file format. Expecting '.txt'"
      exit
    end
  end
  
  def check_arguments_length(input)
    if input.length < 1
      puts "Missing map file. Run process again with the map file as a value after 'main.rb'"
      exit
    elsif input.length > 1
      puts "Too many values. Run process again with only the map file as value after 'main.rb'"
      exit
    end
  end
end
