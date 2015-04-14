module Nippopotamus
  module FormatterUtils
    def title(event, action)
      case action
      when :open_issue, :close_issue, :reopen_issue
        event.payload.issue.title
      when :open_pull_request, :close_pull_request,
           :merge_pull_request, :reopen_pull_request
        event.payload.pull_request.title
      when :review_pull_request, :comment_commit, :comment_issue
        event.payload.comment.body
      end
    end

    def url(event, action)
      case action
      when :open_issue, :close_issue, :reopen_issue
        event.payload.issue.html_url
      when :open_pull_request, :close_pull_request,
           :merge_pull_request, :reopen_pull_request
        event.payload.pull_request.html_url
      when :review_pull_request, :comment_commit, :comment_issue
        event.payload.comment.html_url
      end
    end

    def pluralize(num, unit)
      if num < 2
        "#{num} #{unit}"
      else
        "#{num} #{unit}s"
      end
    end

    def truncate(str, limit)
      str.length > limit-1 ? str.slice(0, limit-1) + "…" : str
    end
  end
end
