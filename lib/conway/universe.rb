module Conway
  class Universe
    def initialize(width, height, seed_pattern)
      @grid = initialize_universe(width, height, seed_pattern)
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

        result[0][0] = seed_pattern

        result
      end
  end
end
