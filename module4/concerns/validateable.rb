# frozen_string_literal: true

module Validateable
  def valid?
    validate!
  rescue
    false
  end
end
