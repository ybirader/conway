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

    attr_reader :cells
    # protected
  end
end
