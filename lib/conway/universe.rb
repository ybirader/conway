module Conway
  class Universe
    DEAD_CELL = "."
    LIVE_CELL = "#"

    def initialize(width, height, seed_pattern)
      @grid = initialize_universe(width, height, seed_pattern)
    end

    def tick
      grid.each_with_index do |row, row_idx|
        row.each_with_index do |cell, col_idx|
          if cell != "."
            live_neighbours_count = count_live_neighbours(row_idx, col_idx)
            grid[row_idx][col_idx] = DEAD_CELL if live_neighbours_count < 2
          end
        end
      end
    end

    def count_live_neighbours(row, col)
      directions = [[1, 0], [-1, 0], [0, 1], [0, -1], [1, 1], [-1, -1], [-1, 1], [1, -1]]

      directions.count do |direction|
        live_cell?(row+direction[0], col+direction[1])
      end
    end

    def to_s
      grid.reduce("") do |result, row|
        result += "#{row.join}\n"
      end
    end

    private
      attr_reader :grid

      def initialize_universe(width, height, seed_pattern)
        result = []

        height.times do
          result.push(Array.new(width).map { |_| DEAD_CELL })
        end

        seed_pattern.each do |cell|
          result[cell[0]][cell[1]] = LIVE_CELL
        end

        result
      end

      def width
        grid[0].length
      end

      def height
        grid.length
      end

      def live_cell?(row, col)
         inbounds?(row, col) && !dead_cell?(row, col)
      end

      def dead_cell?(row, col)
        grid[row][col] == DEAD_CELL
      end

      def inbounds?(row, col)
        row >= 0 && row < height && col >= 0 && col < width
      end
  end
end
