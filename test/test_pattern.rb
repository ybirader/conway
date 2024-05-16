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
end
