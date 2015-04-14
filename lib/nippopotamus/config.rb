module Nippopotamus
  class Config
    attr_reader :access_token

    def initialize
      @access_token = ENV["NIPPOPOTAMUS_ACCESS_TOKEN"]
    end
  end
end
