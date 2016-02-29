module Warehouse
  class Processor
    include ::NewRelic::Agent::Instrumentation::ControllerInstrumentation

    def initialize(storage)
      @storage = storage
    end

    def process(record)
      classification = Classification.new(record)

      Warehouse.logger.info "processing", classification_id: classification.id

      @storage.transaction do
        @storage.delete_classification(classification.id)
        @storage.insert_classification(classification.to_row)

        classification.annotations.each do |annotation|
          @storage.insert_annotation(annotation.to_row)
        end
      end
    end

    add_transaction_tracer :process, category: :task
  end
end
