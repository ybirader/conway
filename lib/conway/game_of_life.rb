require "conway/universe"

module Conway
  class GameOfLife
    def initialize(seed_pattern, generations)
      @generations = generations
      @universe = Universe.new(6, 5, seed_pattern)
    end

    def play
      generations.times { universe.tick }
    end

    def pattern
      universe.pattern
    end

    def to_s
      universe.to_s
    end

    private
      attr_reader :generations, :universe
  end
end
