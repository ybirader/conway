# frozen_string_literal: true

require "test_helper"
require "conway/universe"


describe "Universe" do
  it "should show a grid of width 6 and height 5 with active cells" do
    universe = Conway::Universe.new(6, 5, [[0, 0], [1, 1]])

    expect(universe.to_s).must_equal(<<~UNIVERSE
    #.....
    .#....
    ......
    ......
    ......
    UNIVERSE
    )
  end

  it "should show cells from any enumerable" do
    universe = Conway::Universe.new(6, 5, Conway::Pattern.new([[0, 0]]))

    expect(universe.to_s).must_equal(<<~UNIVERSE
    #.....
    ......
    ......
    ......
    ......
    UNIVERSE
    )
  end

  it "should return immutable pattern" do
    pattern = Conway::Pattern.new([[0, 0]])
    universe = Conway::Universe.new(6, 5, pattern)

    expect(universe.pattern).wont_be_same_as(pattern)
    expect(universe.pattern).must_equal(pattern)
  end

  describe "tick" do
    it "should kill any live cell with fewer than two live neighbours" do
      universe = Conway::Universe.new(6, 5, [[1, 1]])

      universe.tick

      expect(universe.to_s).must_equal(<<~UNIVERSE
      ......
      ......
      ......
      ......
      ......
      UNIVERSE
      )
    end

    it "should keep any live cell with two or three live neighbours alive" do
      universe = Conway::Universe.new(6, 5, [[1, 1], [1, 2], [2, 1], [2, 2]])

      universe.tick

      expect(universe.to_s).must_equal(<<~UNIVERSE
      ......
      .##...
      .##...
      ......
      ......
      UNIVERSE
      )
    end

    it "should kill any live cell with more than three neighbours" do
      universe = Conway::Universe.new(6, 5, [[0, 0], [1, 1], [1, 2], [2, 1], [2, 2]])

      universe.tick

      expect(universe.to_s).must_equal(<<~UNIVERSE
      .#....
      #.#...
      .##...
      ......
      ......
      UNIVERSE
      )
    end

    it "should revive any dead cell with exactly three live neighbours" do
      universe = Conway::Universe.new(6, 5, [[1, 2], [2, 1], [2, 3]])

      universe.tick

      expect(universe.to_s).must_equal(<<~UNIVERSE
      ......
      ..#...
      ..#...
      ......
      ......
      UNIVERSE
      )
    end
  end
end
