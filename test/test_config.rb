require "minitest_helper"

class TestConfig < Minitest::Test
  ACCESS_TOKEN = "dummy_access_token"

  def setup
    ENV["NIPPOPOTAMUS_ACCESS_TOKEN"] = ACCESS_TOKEN

    @config = Nippopotamus::Config.new
  end

  def test_access_token
    assert_equal @config.access_token, ACCESS_TOKEN
  end
end
