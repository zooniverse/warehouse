module Warehouse
  class Workflow
    EXCEPTIONS = {
      "121" => { # AnnoTate
        "T1" => "T-NOTUSED",
        "T2" => "T1",
        "T3" => "T2"
      },
      "338" => { # Wildcam Gorongosa
        "survey" => "T1"
      }
    }

    attr_reader :hash

    def initialize(classification, hash)
      @classification = classification
      @hash = hash
    end

    def find_task(key)
      key = EXCEPTIONS.fetch(hash["id"], {}).fetch(key, key)
      hash.fetch("tasks", {}).fetch(key, "unknown")
    end
  end
end
