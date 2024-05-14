require "test_helper"
require_relative "../drivers/cli"
require_relative "../specifications/play_game"

describe "Conway" do
  it "should play with block pattern" do
    input_pattern = File.expand_path("../testdata/block.rle", __dir__)
    bin_path = File.expand_path("../bin/conway", __dir__)

    driver = Driver::CLI.new(input_pattern, 3, File.read(input_pattern), bin_path)
    Specification::PlayGame.new(driver).start
  end
end
