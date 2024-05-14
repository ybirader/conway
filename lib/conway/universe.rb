module Conway
  class Universe
    def initialize(width, height)
      @grid = initialize_universe(width, height)
    end

    def to_s
      grid.reduce("") do |result, row|
        result += "#{row.join}\n"
      end
    end

    private
      attr_reader :grid

      def initialize_universe(width, height)
        result = []

        height.times do
          result.push(Array.new(width).map { |_| "." })
        end

        result
      end
  end
end
