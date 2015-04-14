require "nippopotamus"
require "thor"

module Nippopotamus
  class CLI < Thor
    desc "today", "print today's activities"
    def today
      puts Nippopotamus::Formatter::Plain.format(Nippopotamus.fetch_activities)
    end

    desc "yesterday", "print yesterday's activities"
    def yesterday
      activities = Nippopotamus.fetch_activities(Date.today - 1)
      puts Nippopotamus::Formatter::Plain.format(activities)
    end
  end
end
