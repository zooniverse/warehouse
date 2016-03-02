module Warehouse
  class SingleAnnotation < Annotation
    def value
      hash["value"]
    end

    def value_label
      return unless hash["value"].is_a?(Integer)
      return unless task_definition["answers"].size > 0

      selected_option = task_definition["answers"][hash["value"]]
      translate(selected_option["label"])
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
  end
end
