module Specification
  class PlayGame
    def initialize(driver)
      @driver = driver
    end

    def start
      driver.play_game
      driver.assert_valid_output
    end

    private
      attr_reader :driver
  end
end
