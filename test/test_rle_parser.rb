require "test_helper"
require "conway/rle_parser"

describe "RLE Parser" do
  test_file = File.expand_path("../testdata/block.rle", __dir__)
  it "should read an rle file" do
    content = Conway::RleParser.read_file(test_file)
    want = File.read(test_file)

    expect(content).must_equal(want)
  end

  it "should raise an invalid file exception for an invalid path" do
    expect(-> { Conway::RleParser.read_file("hello.rle") }).must_raise(Conway::InvalidFileError)
  end

  it "should raise an invalid file exception for a invalid extension" do
    expect(-> { Conway::RleParser.read_file(File.expand_path("../testdata/wrong.txt", __dir__)) }).must_raise(Conway::InvalidFileError)
  end

  it "should ignore comment lines" do
    content = Conway::RleParser.parse(test_file)
    want = <<~CONTENT
    x = 2, y = 2, rule = B3/S23\r
    2o$2o!
    CONTENT

    expect(content.chomp).must_equal(want.chomp)
  end
end
