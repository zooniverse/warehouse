require 'spec_helper'

describe Warehouse::Storage do
  let(:db) { DB }
  let(:storage) { described_class.new(db) }

  before do
    described_class.migrate(db)
  end
end
