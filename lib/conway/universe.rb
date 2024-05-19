module Conway
  class Universe
    DEAD_CELL = "."
    LIVE_CELL = "#"

    def initialize(width, height, seed_pattern)
      @width = width
      @height = height
      @pattern = seed_pattern
    end

    def tick
      new_live_cells = live_neighbours_counter.reduce([]) do |result, (cell, count)|
        result.push(cell) if lives?(cell, count)
        result
      end
      self.pattern = Conway::Pattern.new(new_live_cells)
    end

    def neighbours(cell)
      directions = [[1, 0], [-1, 0], [0, 1], [0, -1], [1, 1], [-1, -1], [-1, 1], [1, -1]]
      directions.map do |direction|
        [row(cell)+row(direction), col(cell)+col(direction)]
      end
    end

    def pattern
      @pattern.clone
    end

    def to_s
      result = ""
      height.times do |row|
        current = ""
        width.times do |col|
          current += pattern.include?([row, col]) ? Conway::Universe::LIVE_CELL : Conway::Universe::DEAD_CELL
        end
        result += "#{current}\n"
      end
      result
    end

    private
      attr_reader :width, :height
      attr_writer :pattern

      def live_neighbours_counter
        result = Hash.new(0)
        pattern.each do |cell|
          neighbours(cell).each do |neighbour|
            result[neighbour] += 1
          end
        end

        result
      end

      def row(cell)
        cell[0]
      end

      def col(cell)
        cell[1]
      end

      def lives?(cell, live_neighbours_count)
        revivable?(cell, live_neighbours_count) || survives?(cell, live_neighbours_count)
      end

      def revivable?(cell, live_neighbours_count)
        live_neighbours_count == 3 && dead_cell?(cell)
      end

      def survives?(cell, live_neighbours_count)
        live_cell?(cell) && (live_neighbours_count == 2 || live_neighbours_count == 3)
      end

      def live_cell?(cell)
        pattern.include?(cell)
      end

      def dead_cell?(cell)
        !live_cell?(cell)
      end
  end
end
