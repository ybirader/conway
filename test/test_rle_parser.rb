require "test_helper"
require "conway/rle_parser"

describe "RLE Parser" do
  block_file = File.expand_path("../testdata/block.rle", __dir__)
  blinker_file = File.expand_path("../testdata/blinker.rle", __dir__)
  glider_file = File.expand_path("../testdata/glider.rle", __dir__)

  tests = [
    { input_file: block_file, want: Set.new([[0, 0], [0, 1], [1, 0], [1, 1]])},
    { input_file: blinker_file, want: Set.new([[0, 0], [0, 1], [0, 2]])},
    { input_file: glider_file, want: Set.new([[0, 1], [1, 2], [2, 0], [2, 1], [2, 2]])},
  ]

  tests.each do |test|
    it "should parse rle pattern file into a set of active cells relative to (0, 0), ignoring comments" do
      expect(Conway::RleParser.parse(test[:input_file])).must_equal(test[:want])
    end
  end
  it "should raise an invalid file exception for an invalid path" do
    expect(-> { Conway::RleParser.parse("hello.rle") }).must_raise(Conway::InvalidFileError)
  end

  it "should raise an invalid file exception for a invalid extension" do
    expect(-> { Conway::RleParser.parse(File.expand_path("../testdata/wrong.txt", __dir__)) }).must_raise(Conway::InvalidFileError)
  end
end
