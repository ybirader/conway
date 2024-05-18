require "test_helper"
require "conway/cli"


describe "CLI" do
  it "should output pattern in rle format" do
    seed_pattern_path = File.expand_path("../testdata/block.rle", __dir__)
    output = StringIO.new
    Conway::CLI.new([seed_pattern_path, 2], output).start
    expect(output.string).must_equal("2o$2o!\n")
  end
end
