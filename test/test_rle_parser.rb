require "test_helper"
require "conway/rle_parser"

describe "RLE Parser" do
  block_file = File.expand_path("../testdata/block.rle", __dir__)
  blinker_file = File.expand_path("../testdata/blinker.rle", __dir__)
  glider_file = File.expand_path("../testdata/glider.rle", __dir__)

  tests = [
    { input_type: :file, input: block_file, want: Set.new([[0, 0], [0, 1], [1, 0], [1, 1]])},
    { input_type: :file, input: blinker_file, want: Set.new([[0, 0], [0, 1], [0, 2]])},
    { input_type: :file, input: glider_file, want: Set.new([[0, 1], [1, 2], [2, 0], [2, 1], [2, 2]])},
    { input_type: :memory, input: "11o!", want: Set.new([[0, 0], [0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7], [0, 8], [0, 9], [0, 10]])},
    { input_type: :memory, input: "# hello!", want: Set.new },
  ]

  tests.each do |test|
    it "should parse rle pattern file into a set of active cells relative to (0, 0), ignoring comments" do
      case test[:input_type]
      when :file then expect(Conway::RleParser.parse_file(test[:input])).must_equal(test[:want])
      when :memory then expect(Conway::RleParser.parse(test[:input])).must_equal(test[:want])
      end
    end
  end
  it "should raise an invalid file exception for an invalid path" do
    expect(-> { Conway::RleParser.parse_file("hello.rle") }).must_raise(Conway::InvalidFileError)
  end

  it "should raise an invalid file exception for a invalid extension" do
    expect(-> { Conway::RleParser.parse_file(File.expand_path("../testdata/wrong.txt", __dir__)) }).must_raise(Conway::InvalidFileError)
  end
end
