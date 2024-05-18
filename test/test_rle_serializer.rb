require "test_helper"
require "conway/rle_serializer"


describe "RLE Serializer" do
  tests = [
    { name: "should serialize 1d pattern", cells: [[0, 0], [0, 1]], want: "2o!"},
    { name: "should serialize 2d pattern", cells: [[0, 0], [0, 1], [1, 0], [1, 1]], want: "2o$2o!"},
    { name: "should serialize pattern with live and dead cells", cells: [[0, 1], [1, 2], [2, 0], [2, 1], [2, 2]], want: "bob$2bo$3o!"},
  ]

  tests.each do |test|
    it test[:name] do
      expect(Conway::RleSerializer.serialize(test[:cells])).must_equal(test[:want])
    end
  end
end
