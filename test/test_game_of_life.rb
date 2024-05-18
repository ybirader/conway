require "test_helper"
require "conway/game_of_life"

describe "Game of Life" do
  it "should play three generations with a block seed pattern" do
    block_file = File.expand_path("../testdata/block.rle", __dir__)
    seed_pattern = Conway::Pattern.from_rle(block_file)
    game = Conway::GameOfLife.new(seed_pattern, 3)
    expect(game.to_s).must_equal(<<~GAME
    ##....
    ##....
    ......
    ......
    ......
    GAME
    )

    game.play

    expect(game.to_s).must_equal(<<~GAME
    ##....
    ##....
    ......
    ......
    ......
    GAME
    )
  end

  it "should return pattern" do
    block_file = File.expand_path("../testdata/block.rle", __dir__)
    seed_pattern = Conway::Pattern.from_rle(block_file)
    game = Conway::GameOfLife.new(seed_pattern, 3)

    game.play

    want = Conway::Pattern.new([[0, 0], [0, 1], [1, 0], [1, 1]])
    expect(game.pattern).must_equal(want)
  end
end
