module Warehouse
  class Workflow
    attr_reader :hash

    def initialize(classification, hash)
      @classification = classification
      @hash = hash
    end

    def find_task(key)
      hash.fetch("tasks", {}).fetch(key)
    end
  end
end
