module Conway
  class Pattern
    attr_reader :cells

    def initialize(live_cells = [])
      @cells = Set.new(live_cells)
    end

    def ==(other)
      cells == other.cells
    end
  end
end
