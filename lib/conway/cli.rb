require "conway/game_of_life"
require "conway/pattern"

module Conway
  class CLI
    def initialize(args, output = $stdin)
      @output = output
      @seed_pattern_path, @generations = args
    end

    def start
      game = Conway::GameOfLife.new(Conway::Pattern.from_rle(seed_pattern_path), generations)
      game.play
      output.puts game.pattern.to_rle
    end

    private
      attr_reader :output, :seed_pattern_path, :generations
  end
end
