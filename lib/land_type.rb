class Land
  def initialize(map_character)
    land_types = {
      "o" => {
        symbol: :o,
        type: :Plains,
        fuel_cost: 1,
        clearable: true
      },
      "r" => {
        symbol: :r,
        type: :Rocky,
        fuel_cost: 2,
        clearable: true
      },
      "t" => {
        symbol: :t,
        type: :RemovableTree,
        fuel_cost: 2,
        clearable: true
      },
      "T" => {
        symbol: :T,
        type: :ProtectedTree,
        fuel_cost: 2,
        clearable: false
      },
      "cleared" => {
        symbol: :-,
        type: :Cleared,
        fuel_cost: 1,
        clearable: true
      },
      "out" => {
        symbol: :OUT,
        type: :OffSite,
        fuel_cost: nil,
        clearable: false
      }
    }

    @land = land_types[map_character]
  end

  def symbol
    @land[:symbol]
  end
  
  def type
    @land[:type]
  end

  def clearable?
    @land[:clearable] == true
  end

  def cost
    @land[:fuel_cost]
  end
end