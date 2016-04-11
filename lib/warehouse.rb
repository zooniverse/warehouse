require 'yaml'
require 'logger'
require 'newrelic_rpm'
require 'honeybadger'
require 'sequel'
require 'telekinesis'
require 'dotenv'

module Warehouse
  class NullLogger
    def fatal(*args); end
    def error(*args); end
    def warn(*args); end
    def info(*args); end
    def debug(*args); end
  end

  class LoggerLogger
    def initialize(logger)
      @logger = logger
    end

    def fatal(message = nil, metadata = {})
      @logger.fatal("#{message || yield} #{JSON.dump(metadata)}")
    end

    def error(message = nil, metadata = {})
      @logger.error("#{message || yield} #{JSON.dump(metadata)}")
    end

    def warn(message = nil, metadata = {})
      @logger.warn("#{message || yield} #{JSON.dump(metadata)}")
    end

    def info(message = nil, metadata = {})
      @logger.info("#{message || yield} #{JSON.dump(metadata)}")
    end

    def debug(message = nil, metadata = {})
      @logger.debug("#{message || yield} #{JSON.dump(metadata)}")
    end
  end

  def self.config_path(filename)
    File.expand_path(File.join('..', '..', 'config', filename), __FILE__)
  end

  def self.load_config(filename, environment)
    path = config_path(filename)
    YAML.load_file(path).fetch(environment.to_s)
  end

  def self.logger
    return @logger if @logger
    self.logger = LoggerLogger.new(Logger.new(STDOUT))
  end

  def self.logger=(logger)
    @logger = logger
    logger
  end
end

Warehouse.logger
Dotenv.load
NewRelic::Agent.manual_start
Honeybadger.start(:'config.path' => Warehouse.config_path("honeybadger.yml")) if File.exist?(Warehouse.config_path("honeybadger.yml"))

DB = Sequel.connect(Warehouse.load_config('database.yml', ENV.fetch("RAILS_ENV")))
DB.extension :pg_json

require_relative 'warehouse/storage'
require_relative 'warehouse/classification'
require_relative 'warehouse/processor'

module Warehouse
  def self.start(environment)
    storage   = Warehouse::Storage.new(DB)
    processor = Warehouse::Processor.new(storage)
    input = Telekinesis::Consumer::KCL.new(stream: ENV.fetch("AWS_KINESIS_STREAM", "zooniverse-production"),
                                           app:    ENV.fetch("AWS_KINESIS_APPNAME", "warehouse-development")) do
      Telekinesis::Consumer::Block.new do |records, checkpointer, millis_behind|
        records.each do |record|
          begin
            json = String.from_java_bytes(record.data.array)
            hash = JSON.parse(json)

            if hash.fetch("source") == "panoptes" && hash.fetch("type") == "classification"
              processor.process(hash)

            end
          rescue StandardError => ex
            puts '='*100
            puts ex.message
            puts ex.backtrace
            puts '='*100
            Honeybadger.notify(ex)
          end
        end

        checkpointer.checkpoint
      end
    end

    input
  rescue StandardError => exception
    Honeybadger.notify(exception)
    raise
  end
end
