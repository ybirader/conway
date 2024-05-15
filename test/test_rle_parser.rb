require "test_helper"
require "conway/rle_parser"

describe "RLE Parser" do
  test_file = File.expand_path("../testdata/block.rle", __dir__)
  it "should read an rle file" do
    content = Conway::RleParser.read_file(test_file)
    want = File.read(test_file)

    expect(content).must_equal(want)
  end
end
