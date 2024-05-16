require "conway/pattern"

module Conway
  class RleParser
    RLE_EXTENSION = ".rle"
    ROW_DELIMITER = "$"
    PATTERN_ENDING = "!"
    COMMENT_DELIMTER = "#"
    LIVE_CELL = "o"

    class << self
      def parse_file(path)
        new(read_file(path)).parse
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
    end

    def initialize(content)
      @content = content
    end

    def parse
      pattern = extract_pattern
      return Conway::Pattern.new if pattern.empty?
      rows = expand_pattern(pattern)
      Conway::Pattern.new(get_active_cells(rows))
    end

    private
      attr_reader :content

      def extract_pattern
        content.split("\n").select { |line| !line.start_with?(COMMENT_DELIMTER) && line.chomp.end_with?(PATTERN_ENDING) }.first || ""
      end

      def expand_pattern(pattern)
        pattern.chomp(PATTERN_ENDING).split(ROW_DELIMITER).map { |row| expand(row) }
      end

      def expand(row)
        count = ""
        result = ""

        row.each_char do |char|
          if numeric?(char)
            count += char
          else
            count = "1" if count.empty?
            result += char * count.to_i
            count = ""
          end
        end

        result
      end

      def get_active_cells(rows)
        result = []
        rows.each_with_index do |row, row_idx|
          row.each_char.with_index do |cell, col_idx|
            if cell == "o"
              result.push([row_idx, col_idx])
            end
          end
        end
        result
      end

      def live_cell?(cell)
        cell == LIVE_CELL
      end

      def numeric?(char)
        char.match?(/^\d+$/)
      end
  end
end
