require "test_helper"
require "conway/rle_parser"

describe "RLE Parser" do
  test_file = File.expand_path("../testdata/block.rle", __dir__)
  it "should parse rle pattern file into a set of active cells relative to (0, 0), ignoring comments" do
    content = Conway::RleParser.parse(test_file)
    want = Set.new([[0, 0], [0, 1], [1, 0], [1, 1]])

    expect(content).must_equal(want)
  end
  it "should raise an invalid file exception for an invalid path" do
    expect(-> { Conway::RleParser.parse("hello.rle") }).must_raise(Conway::InvalidFileError)
  end

  it "should raise an invalid file exception for a invalid extension" do
    expect(-> { Conway::RleParser.parse(File.expand_path("../testdata/wrong.txt", __dir__)) }).must_raise(Conway::InvalidFileError)
  end
end
