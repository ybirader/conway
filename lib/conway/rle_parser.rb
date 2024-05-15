module Conway
  class RleParser
    def self.read_file(path)
      begin
        File.read(path)
      rescue Errno::ENOENT
        raise Conway::UnknownFileError.new("could not read file at #{path}")
      end
    end
  end
end
