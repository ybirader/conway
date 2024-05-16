module Conway
  class RleParser
    RLE_EXTENSION = ".rle"
    ROW_DELIMITER = "$"
    PATTERN_ENDING = "!"

    class << self

      def parse(path)
        content = read_file(path)
        pattern = content.split("\n").select { |line| line.chomp.end_with?(PATTERN_ENDING) }.first
        rows = pattern.chomp(PATTERN_ENDING).split(ROW_DELIMITER).map { |row| expand(row) }

        result = Set.new

        rows.each_with_index do |row, row_idx|
          row.each_char.with_index do |cell, col_idx|
            if cell == "o"
              result.add([row_idx, col_idx])
            end
          end
        end

        result
      end

      private
        def read_file(path)
          raise Conway::InvalidFileError.new("must be a valid .rle file. #{path} is not.") unless File.extname(path) == RLE_EXTENSION

          begin
            File.read(path)
          rescue Errno::ENOENT
            raise Conway::InvalidFileError.new("must be a valid .rle file. #{path} is not.")
          end
        end

        def expand(row)
          count = ""
          result = ""

          row.each_char do |char|
            if char.match?(/^\d+$/)
              count += char
            else
              count = "1" if count.empty?
              result += char * count.to_i
              count = ""
            end
          end

          result
        end
    end
  end
end
