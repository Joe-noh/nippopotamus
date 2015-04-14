require "nippopotamus"
require "thor"

module Nippopotamus
  class CLI < Thor
    option :username, type: :string
    desc "today", "print today's activities"
    def today
      config = Nippopotamus::Config.new
      config.user_name = options[:username]

      activities = Nippopotamus.fetch_activities(config)
      puts Nippopotamus::Formatter::Plain.format(activities)
    end

    option :username, type: :string
    desc "yesterday", "print yesterday's activities"
    def yesterday
      config = Nippopotamus::Config.new
      config.user_name = options[:username]
      config.date = Date.today - 1

      activities = Nippopotamus.fetch_activities(config)
      puts Nippopotamus::Formatter::Plain.format(activities)
    end
  end
end
