module Warehouse
  class User
    attr_reader :hash

    def initialize(classification, hash)
      @classification = classification
      @hash = hash
    end

    def id
      "TODO"
    end

    def name
      "TODO"
    end

    def ip_address
      "TODO"
    end
  end
end
