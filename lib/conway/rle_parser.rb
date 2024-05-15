module Conway
  class RleParser
    RLE_EXTENSION = ".rle"

    def self.parse(path)
      content = read_file(path)
      content.split("\n").reject { |line| line.start_with?("#") }.join("\n")
    end

    def self.read_file(path)
      raise Conway::InvalidFileError.new("must be a valid .rle file. #{path} is not.") unless File.extname(path) == RLE_EXTENSION

      begin
        File.read(path)
      rescue Errno::ENOENT
        raise Conway::InvalidFileError.new("must be a valid .rle file. #{path} is not.")
      end
    end
  end
end
