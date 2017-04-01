module Validateable
  def valid?
    validate!
  rescue
    false
  end
end
