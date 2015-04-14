require "minitest_helper"

class TestFormatterPlain < Minitest::Test

  def test_format_multiple_repo
    events = {
      "Joe-noh/nippopotamus" => {},
      "Joe-noh/declaimer" => {}
    }

    formatted = Nippopotamus::Formatter::Plain.format(events)

    assert_match "Joe-noh/nippopotamus", formatted
    assert_match "Joe-noh/declaimer", formatted
  end

  def test_format_no_event
    assert_equal "", Nippopotamus::Formatter::Plain.format({})
  end
end
