require "open3"

module Driver
  class CLI
    include Minitest::Assertions

    def initialize(input_pattern, generations, expected_output, bin_path)
      @input_pattern = input_pattern
      @generations = generations
      @expected_output = expected_output
      @bin_path = bin_path
      @assertions = 0
      @output = ""
      @error = ""
    end

    def play_game
      Open3.popen3("ruby #{bin_path} #{input_pattern} #{generations}") do |_, stdout, stderr|
        self.output = stdout.read
        self.error = stderr.read.chomp
      end
    end

    def assert_valid_output
      assert_empty error
      assert_equal expected_output, output
    end

    private
      attr_accessor :assertions, :output, :error
      attr_reader :input_pattern, :generations, :expected_output, :bin_path
  end
end
