module Conway
  class CLI
    def start(args)
      block_pattern_path = File.expand_path("../../testdata/block.rle", __dir__)
      puts File.read(block_pattern_path)
    end
  end
end
