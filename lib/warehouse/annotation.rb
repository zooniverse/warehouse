module Warehouse
  class Annotation
  end
end

require 'warehouse/single_annotation'
require 'warehouse/multiple_annotation'
require 'warehouse/drawing_annotation'
require 'warehouse/survey_annotation'
require 'warehouse/text_annotation'
require 'warehouse/crop_annotation'

module Warehouse
  class Annotation
    def self.from(classification, annotation_hash)
      [new(classification, annotation_hash)]
    end

    attr_reader :classification, :hash

    def initialize(classification, hash)
      @classification = classification
      @hash = hash
    end

    def to_row
      {
        classification_id: classification.id,
        task: task,
        task_label: task_label,
        task_type: task_type,
        tool: tool,
        tool_label: tool_label,
        value: value,
        value_label: value_label,
        choice: choice,
        answers: answers,
        filters: filters,
        marking: marking,
        frame: frame,
        details: details,
      }
    end

    def task
      hash["task"]
    end

    def task_label
      translate(task_definition["question"] || task_definition["instruction"])
    end

    def task_type
      task_definition["type"] || "unknown"
    end

    def tool
      nil
    end

    def tool_label
      nil
    end

    def value
      JSON.dump(hash)
    end

    def value_label
      nil
    end

    def choice
      nil
    end

    def answers
      nil
    end

    def filters
      nil
    end

    def marking
      nil
    end

    def frame
      nil
    end

    def details
      nil
    end

    private

    def task_definition
      classification.find_task(task)
    end

    def translate(key)
      string = classification.translate(key)
      string && string.gsub("\n", "")
    end
  end
end
