module Conway
  class Universe
    def initialize(width, height, seed_pattern)
      @grid = initialize_universe(width, height, seed_pattern)
    end

    def tick
      grid.length.times do |row|
        grid[0].length.times do |col|
          cell = grid[row][col]
          if cell != "."
            live_neighbours_count = count_live_neighbours(row, col)
            grid[row][col] = "." if live_neighbours_count < 2
          end
        end
      end
    end

    def count_live_neighbours(row, col)
      result = 0
      directions = [[1, 0], [-1, 0], [0, 1], [0, -1], [1, 1], [-1, -1], [-1, 1], [1, -1]]

      directions.each do |direction|
        if row + direction[0] >= 0 && row + direction[0] < grid.length && col + direction[1] >= 0 && col + direction[1] < grid[0].length && grid[row+direction[0]][col+direction[1]] != "."
          result += 1
        end
      end

      result
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
          result.push(Array.new(width).map { |_| "." })
        end

        seed_pattern.each do |cell|
          result[cell[0]][cell[1]] = "#"
        end

        result
      end
  end
end
