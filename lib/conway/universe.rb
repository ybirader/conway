module Conway
  class Universe
    DEAD_CELL = "."
    LIVE_CELL = "#"

    def initialize(width, height, seed_pattern)
      @grid = initialize_universe(width, height, seed_pattern)
    end

    def tick
      cells_to_kill = []
      cells_to_revive = []

      grid.each_with_index do |row, row_idx|
        row.each_with_index do |cell, col_idx|
          live_neighbours_count = count_live_neighbours(row_idx, col_idx)
          cells_to_kill.push([row_idx, col_idx]) if live_cell?(row_idx, col_idx) && live_neighbours_count < 2 || live_neighbours_count > 3
          cells_to_revive.push([row_idx, col_idx]) if dead_cell?(row_idx, col_idx) && live_neighbours_count == 3
        end
      end

      cells_to_kill.each do |cell|
        grid[cell[0]][cell[1]] = DEAD_CELL
      end

      cells_to_revive.each do |cell|
        grid[cell[0]][cell[1]] = LIVE_CELL
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

        height.times do |row_idx|
          row = []
          width.times do |col_idx|
            if seed_pattern.include?([row_idx, col_idx])
              row.push(LIVE_CELL)
            else
              row.push(DEAD_CELL)
            end
          end
          result.push(row)
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
