require "nippopotamus"
require "thor"

module Nippopotamus
  class CLI < Thor
    desc "today", "print today's date"
    def today
      puts Date.today.to_s
    end
  end
end
