require "test_helper"
require_relative "../drivers/cli"
require_relative "../specifications/play_game"

describe "Conway" do
  it "should play with block pattern" do
    input_pattern = File.expand_path("../testdata/block.rle", __dir__)
    bin_path = File.expand_path("../bin/conway", __dir__)

    driver = Driver::CLI.new(input_pattern, 3, "2o$2o!\n", bin_path)
    Specification::PlayGame.new(driver).start
  end

  it "should play with blinker pattern" do
    skip "todo"

    input_pattern = File.expand_path("../testdata/blinker.rle", __dir__)
    bin_path = File.expand_path("../bin/conway", __dir__)
    output_pattern = <<~BLINKER
    #N Blinker
    #O John Conway
    #C A period 2 oscillator that is the smallest and most common oscillator.
    #C www.conwaylife.com/wiki/index.php?title=Blinker
    x = 1, y = 3, rule = B3/S23
    1o$1o$1o!
    BLINKER

    driver = Driver::CLI.new(input_pattern, 2, output_pattern, bin_path)
    Specification::PlayGame.new(driver).start
  end
end
