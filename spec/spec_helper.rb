ENV["RAILS_ENV"] ||= "test"
Dir[File.expand_path("../support/**/*.rb", __FILE__)].each { |f| require f }
require 'approvals/rspec'
require 'webmock/rspec'
require 'pry'

require 'warehouse'
Warehouse.logger = Warehouse::NullLogger.new

RSpec.configure do |config|
  config.before(:suite) do
    Warehouse::Storage.migrate(DB)
  end

  config.before(:example) do
    DB[:classifications].delete
    DB[:annotations].delete

    # Stub out any calls the NewRelic gem makes
    stub_request(:get, "http://169.254.169.254/2008-02-01/meta-data/instance-type")
    stub_request(:post, "https://collector.newrelic.com/agent_listener/14//get_redirect_host?marshal_format=json")
    stub_request(:post, "https://collector.newrelic.com/agent_listener/14//connect?marshal_format=json")
  end
end
