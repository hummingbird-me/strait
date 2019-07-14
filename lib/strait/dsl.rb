# frozen_string_literal: true

class Strait
  class DSL
    def initialize(limits = [], &block)
      @limits = limits
      instance_eval(&block)
    end

    def limit(count, per:, buckets: 60)
      @limits << { count: count, period: per, buckets: buckets }
    end
  end
end
