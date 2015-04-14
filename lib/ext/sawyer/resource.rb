module Sawyer
  class Resource
    def occured_at?(date)
      self.created_at.getlocal.to_date == date
    end
  end
end
