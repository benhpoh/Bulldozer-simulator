require_relative 'cost'

class Output
  def initialize(commands, routes, end_map)
    @commands = commands
    @routes = routes
    @end_map = end_map
    @unit_cost = {
      overhead: 1,
      fuel: 1,
      uncleared: 3,
      protected_tree: 10,
      paint_damage: 2
    }
  end

  def welcome
    puts "Welcome to the Aconex site clearing simulator. This is a map of the site:\n "

    puts @end_map.map { |row| row.map(&:symbol).join(" ") }

    puts "\nThe bulldozer is currently located at the Northern edge of the site, immediately to the West of the site, and facing East.\n "
  end
  
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

  private

  def summarize_cost
    cost = Cost.new(@commands, @routes, @end_map)
    overhead_quantity, fuel_quantity, uncleared_quantity, paint_damage = cost.calculate_total

    table_data = [
      {
        item: "Communication overhead",
        quantity: overhead_quantity,
        cost: overhead_quantity * @unit_cost[:overhead]
      },
      {
        item: "Fuel usage",
        quantity: fuel_quantity,
        cost: fuel_quantity * @unit_cost[:fuel]
      },
      {
        item: "Uncleared squares",
        quantity: uncleared_quantity,
        cost: uncleared_quantity * @unit_cost[:uncleared]
      },
      {
        item: "Destruction of protected tree",
        quantity: 0,
        cost: 0 * @unit_cost[:protected_tree]
      },
      {
        item: "Paint damage to bulldozer",
        quantity: paint_damage,
        cost: paint_damage * @unit_cost[:paint_damage]
      }
    ]

    total_cost = sum_total_cost(table_data)

    {table: table_data, total: total_cost}
  end

  def sum_total_cost(output)
    output.map { |item| item[:cost] }.sum
  end

end