module Conway
  class RleSerializer
    def self.serialize(cells)
      new(cells).serialize
    end

    def initialize(cells)
      @cells = cells
    end

    def serialize
      min_row_cell, max_row_cell = cells.minmax { |a, b| a[0] <=> b[0] }.map { |cell| cell[0] }
      min_col_cell, max_col_cell = cells.minmax { |a, b| a[1] <=> b[1] }.map { |cell| cell[1] }

      result = []

      min_row_cell.upto(max_row_cell) do |row_idx|
        row = ""
        min_col_cell.upto(max_col_cell) do |col_idx|
          row += cells.include?([row_idx, col_idx]) ? "o" : "b"
        end
        result.push(encode(row))
      end

      result.join("$") + "!"
    end

    private
      attr_reader :cells

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
