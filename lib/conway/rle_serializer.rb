require "conway/constants"

module Conway
  class RleSerializer
    include Conway::Constants::Rle

    def self.serialize(cells)
      new(cells).serialize
    end

    def initialize(cells)
      @cells = cells
    end

    def serialize
      min_row_cell, max_row_cell = row_boundaries
      min_col_cell, max_col_cell = col_boundaries

      result = []

      min_row_cell.upto(max_row_cell) do |row_idx|
        row = ""
        min_col_cell.upto(max_col_cell) do |col_idx|
          row += cells.include?([row_idx, col_idx]) ? LIVE_CELL : DEAD_CELL
        end
        result.push(encode(row))
      end

      result.join(ROW_DELIMITER) + PATTERN_ENDING
    end

    private
      attr_reader :cells

      def row_boundaries
        cells.minmax { |a, b| a[0] <=> b[0] }.map { |cell| cell[0] }
      end

      def col_boundaries
        cells.minmax { |a, b| a[1] <=> b[1] }.map { |cell| cell[1] }
      end

      def encode(pattern_string)
        result = ""
        current_char = ""
        count = 0

        pattern_string.each_char do |char|
          if current_char.empty? || char != current_char
            result += count > 1 ? "#{count}#{current_char}" : current_char
            count = 0
            current_char = char
          end
          count += 1
        end
        result += count > 1 ? "#{count}#{current_char}" : current_char
        result
      end
  end
end
