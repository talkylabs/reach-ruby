# frozen_string_literal: true

module Reach
  class ReachResponse
    attr_accessor :status_code, :body

    # @deprecated Use 'Reach::Response' instead.
    def initialize(status_code, body)
      warn "'Reach::ReachResponse' has been deprecated. Use 'Reach::Response' instead."
      response = Reach::Response.new(status_code, body)
      @status_code = response.status_code
      @body = response.body
    end

    def to_s
      "[#{@status_code}] #{@body}"
    end
  end
end
