module Warehouse
  class WorkflowContent
    attr_reader :hash

    def initialize(classification, hash)
      @classification = classification
      @hash = hash
    end

    def translate(key)
      hash.fetch("strings", {}).fetch(key, key)
    end
  end
end
