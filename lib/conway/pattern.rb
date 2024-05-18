require "conway/rle_parser"

module Conway
  class Pattern
    def self.from_rle(path, parser = Conway::RleParser)
      new(parser.parse_file(path))
    end

    def initialize(live_cells = [])
      @cells = Set.new(live_cells)
    end

    def include?(cell)
      cells.include?(cell)
    end

    def each(&block)
      cells.each(&block)
    end

    def ==(other)
      cells == other.cells
    end

    def to_rle
      min_row_cell, max_row_cell = cells.minmax { |a, b| a[0] <=> b[0] }
      min_col_cell, max_col_cell = cells.minmax { |a, b| a[1] <=> b[1] }

      result = ""

      min_row_cell[0].upto(max_row_cell[0]) do |row|
        min_col_cell[1].upto(max_col_cell[1]) do |col|
          result += include?([row, col]) ? "o" : "b"
        end
      end

      encode(result) + "!"
    end

    protected
      attr_reader :cells

    private
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
