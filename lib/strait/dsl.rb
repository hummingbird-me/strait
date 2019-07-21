# frozen_string_literal: true

class Strait
  class DSL
    def initialize(rules = [], &block)
      @rules = rules
      instance_eval(&block)
    end

    def limit(count, per:, buckets: 60)
      @rules << { count: count, period: per, buckets: buckets }
    end
  end
end
