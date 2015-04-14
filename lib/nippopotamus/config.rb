module Nippopotamus
  class Config
    attr_accessor :date, :access_token, :api_endpoint, :user_name

    def initialize
      @date = Date.today
      @access_token = ENV["NIPPOPOTAMUS_ACCESS_TOKEN"]
      @api_endpoint = ENV["NIPPOPOTAMUS_API_ENDPOINT"] || "https://api.github.com/"
      @user_name = nil
    end
  end
end
