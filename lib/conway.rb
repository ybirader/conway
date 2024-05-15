# frozen_string_literal: true

require_relative "conway/version"
require_relative "conway/cli"

module Conway
  class Error < StandardError; end
  class InvalidFileError < StandardError; end
end
