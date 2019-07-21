# frozen_string_literal: true

require 'strait/version'
require 'strait/dsl'
require 'strait/configuration'

# A rate-limiter which provides defense for your nation-state. Or your API.
class Strait
  attr_reader :name

  def initialize(name, limits = [])
    @name = name
    @limits = limits
    Strait::DSL.new(@limits, &Proc.new) if block_given?
  end

  def self.configuration=(config)
    Strait::Configuration.default = Strait::Configuration.new(config)
  end
end
