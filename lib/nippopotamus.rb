require "octokit"

require "ext/sawyer/resource"
require "nippopotamus/version"
require "nippopotamus/config"
require "nippopotamus/cli"
require "nippopotamus/formatter/plain"

module Nippopotamus
  class << self
    TARGET_EVENTS = %w(
      CommitCommentEvent IssueCommentEvent IssuesEvent
      PullRequestEvent PullRequestReviewCommentEvent
    )

    def fetch_activities(config)
      unless config.access_token
        raise "ENV['NIPPOPOTAMUS_ACCESS_TOKEN'] is required"
      end

      client = Octokit::Client.new(access_token: config.access_token)
      client.api_endpoint = config.api_endpoint
      client.auto_paginate = false
      user = config.user_name || client.login

      events = client.user_events(user).select {|e|
        e.occured_at?(config.date) and TARGET_EVENTS.member?(e.type)
      }

      group_events(events)
    end

    private

    def group_events(events)
      grouped_events = events.group_by {|e| e.repo.name }
      grouped_events.each {|repo, events|
        grouped_events[repo] = group_by_action(events)
      }
    end

    def group_by_action(events)
      events.group_by do |e|
        case e.type
        when "CommitCommentEvent"; :comment_commit
        when "IssueCommentEvent";  :comment_issue
        when "IssuesEvent"
          case e.payload.action
          when "opened";  :open_issue
          when "closed";  :close_issue
          when "reopend"; :reopen_issue
          else; next
          end
        when "PullRequestEvent"
          case e.payload.action
          when "opened"; :open_pull_request
          when "closed"
            e.payload.pull_request.merged ? :merge_pull_request : :close_pull_request
          when "reopend"; :reopen_pull_request
          else; next
          end
        when "PullRequestReviewCommentEvent"; :review_pull_request
        else; next
        end
      end
    end
  end
end
