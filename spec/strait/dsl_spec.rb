# frozen_string_literal: true

require 'strait/dsl'

RSpec.describe Strait::DSL do
  describe '#limit' do
    it 'should add rules to the passed list' do
      rules = []
      expect {
        described_class.new(rules) do
          limit 5, per: 60, buckets: 60
        end
      }.to(change { rules.count }.by(1))
    end

    it 'should create rules with the right structure' do
      rules = []
      described_class.new(rules) do
        limit 5, per: 60, buckets: 6
      end
      expect(rules.last).to eq(count: 5, period: 60, buckets: 6)
    end

    it 'should default to 60 buckets per period' do
      rules = []
      described_class.new(rules) do
        limit 5, per: 60
      end
      expect(rules.last[:buckets]).to eq(60)
    end
  end
end
