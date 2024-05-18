require "test_helper"
require "conway/pattern"

describe "Pattern" do
  it "should be initialized with an 2d nested array of cells" do
    expect(Conway::Pattern.new).wont_be_nil
    expect(Conway::Pattern.new([[1, 2], [2, 3]])).wont_be_nil
  end

  it "should have value equality" do
    pattern_one = Conway::Pattern.new([[1, 2]])
    pattern_two = Conway::Pattern.new([[1, 2]])

    expect(pattern_one).must_equal(pattern_two)
  end

  it "should create pattern from rle file" do
    block_file = File.expand_path("../testdata/block.rle", __dir__)
    pattern = Conway::Pattern.from_rle(block_file)

    [[0, 0], [0, 1], [1, 0], [1, 1]].each do |expected_cell|
      expect(pattern).must_include(expected_cell)
    end
  end

  tests = [
    { name: "should serialize 1d pattern", pattern: Conway::Pattern.new([[0, 0], [0, 1]]), want: "2o!"},
    { name: "should serialize 2d pattern", pattern: Conway::Pattern.new([[0, 0], [0, 1], [1, 0], [1, 1]]), want: "2o$2o!"},
    { name: "should serialize pattern with live and dead cells", pattern: Conway::Pattern.new([[0, 1], [1, 2], [2, 0], [2, 1], [2, 2]]), want: "bob$2bo$3o!"},
  ]

  tests.each do |test|
    it test[:name] do
      expect(test[:pattern].to_rle).must_equal(test[:want])
    end
  end
end
