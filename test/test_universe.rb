# frozen_string_literal: true

require "test_helper"
require "conway/universe"


describe "Universe" do
  it "should show a grid of width 6 and height 5 with initial seed pattern" do
    universe = Conway::Universe.new(6, 5, "#")

    expect(universe.to_s).must_equal(<<~UNIVERSE
    #.....
    ......
    ......
    ......
    ......
    UNIVERSE
    )
  end
end
