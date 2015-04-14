require "nippopotamus/formatter_utils"

module Nippopotamus
  module Formatter
    module Plain
      class << self
        include Nippopotamus::FormatterUtils

        ACTIONS = %i(
          open_issue close_issue reopen_issue open_pull_request
          close_pull_request merge_pull_request reopen_pull_request
          review_pull_request comment_commit comment_issue
        )

        def format(events)
          lines = []
          events.each do |repo, events_group|
            lines << "◆ #{repo}"

            ACTIONS.each do |action|
              events = events_group[action]
              if events
                lines << "◇ #{action} (#{events.size})"
                events.each do |event|
                  title = title(event, action)
                  title = truncate(title, (title.ascii_only? ? 90 : 50))
                  lines << "　✓ #{title}"
                  lines << "　　　#{url(event, action)}"
                end
              end
            end

            lines << ""
          end

          lines.join "\n"
        end
      end
    end
  end
end
