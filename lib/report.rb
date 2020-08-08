require_relative 'cost'

class Report
  def initialize(commands, routes, end_map)
    @commands = commands
    @routes = routes
    @end_map = end_map
  end

  def self.display_welcome(map)
    puts "Welcome to the Aconex site clearing simulator. This is a map of the site:\n "

    puts map.map { |row| row.map(&:symbol).join(" ") }

    puts "\nThe bulldozer is currently located at the Northern edge of the site, immediately to the West of the site, and facing East.\n "
  end
  
  def display_summary
    commands_issued()
    cost_table()
    footer()
  end
  
  private
  
  def commands_issued
    puts @commands.join(", ") + "\n "
  end

  def cost_table
    summary = summarize_cost()
    table = summary[:table]

    puts "The costs for this land clearing operation were:\n "

    puts "Item".ljust(34) + "Quantity".rjust(8) + "Cost".rjust(8)
    table.each do |row|
      puts row[:item].ljust(34) + row[:quantity].to_s.rjust(8) + row[:cost].to_s.rjust(8)
    end
    puts "-----"
    puts "Total" + summary[:total].to_s.rjust(45) + "\n "

  end

  def footer
    puts "Thank you for using the Aconex site clearing simulator.\n "
    puts "Built with <3 by Ben"
  end

  def summarize_cost
    cost = Cost.new(@commands, @routes, @end_map).calculate_total

    table_data = [
      {
        item: "Communication overhead",
        quantity: cost[:overhead_quantity],
        cost: cost[:overhead_cost]
      },
      {
        item: "Fuel usage",
        quantity: cost[:fuel_quantity],
        cost: cost[:fuel_cost]
      },
      {
        item: "Uncleared squares",
        quantity: cost[:uncleared_quantity],
        cost: cost[:uncleared_cost]
      },
      {
        item: "Destruction of protected tree",
        quantity: 0,
        cost: 0
      },
      {
        item: "Paint damage to bulldozer",
        quantity: cost[:paint_damage],
        cost: cost[:paint_damage_cost]
      }
    ]

    total_cost = sum_total_cost(table_data)

    {table: table_data, total: total_cost}
  end

  def sum_total_cost(table_data)
    table_data.map { |item| item[:cost] }.sum
  end

end