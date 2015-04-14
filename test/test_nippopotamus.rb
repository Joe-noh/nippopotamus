require 'minitest_helper'

class TestNippopotamus < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Nippopotamus::VERSION
  end
end
