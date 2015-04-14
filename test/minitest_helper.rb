$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

module HashDotAccess
  refine Hash do
    def method_missing(method, *params)
      p method
      self[method]
    end
  end
end

require 'nippopotamus'
require 'minitest/autorun'

