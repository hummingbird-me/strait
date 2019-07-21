# frozen_string_literal: true

require 'strait/version'
require 'strait/dsl'
require 'strait/configuration'
require 'strait/rule'

# A rate-limiter which provides natural defenses for your nation-state. Or your API.
class Strait
  class RateLimitExceeded < StandardError; end

  attr_reader :name, :config

  def initialize(name, rules: [], **config)
    @name = name
    @raw_rules = rules
    @config = Strait::Configuration.default.merge(config)

    @raw_rules += Strait::DSL.new(&Proc.new).rules if block_given?
  end

  def limit!(user)
    rules.each { |rule| rule.call(user) }
  end

  def self.configuration=(config)
    Strait::Configuration.default = Strait::Configuration.new(config)
  end

  private

  def rules
    @rules ||= @raw_rules.map do |rule|
      if rule.is_a?(Strait::Rule)
        rule
      else
        Strait::Rule.new(config: @config, name: @name, rule: rule)
      end
    end
  end
end
