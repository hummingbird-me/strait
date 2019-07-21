class Strait
  class RateLimitExceeded < StandardError
    def initialize(period:, count:, total:)
      @period = period
      @count = count
      @total = total
    end

    def to_s
      "Rate Limit Exceeded: #{@count} per #{@period} seconds"
    end
  end
end
