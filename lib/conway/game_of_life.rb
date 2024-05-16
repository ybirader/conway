require "conway/universe"

module Conway
  class GameOfLife
    def initialize(seed_pattern, generations)
      @seed_pattern = seed_pattern
      @generations = generations
      @universe = Universe.new(6, 5, seed_pattern)
    end

    def play
      generations.times { universe.tick }
    end

    def to_s
      universe.to_s
    end

    private
      attr_reader :seed_pattern, :generations, :universe
  end
end
