require 'active_support/core_ext/array/wrap'
require 'active_support/core_ext/hash/except'

module Warehouse
  class SurveyAnnotation < Annotation
    def self.from(classification, annotation_hash)
      # Wildcam Gorongosa's custom survey task does not send in an array of values.
      values = Array.wrap(annotation_hash.fetch("value", []))

      values.map do |single_value|
        new(classification, annotation_hash.except("value").merge("value" => single_value))
      end
    end

    def value
      hash.fetch("value").fetch("choice")
    end

    def value_label
      translate("#{task}.choices.#{value}.label")
    end

    def answers
      format_hash_as_string(hash.fetch("value").fetch("answers"))
    end

    def filters
      format_hash_as_string(hash.fetch("value").fetch("filters"))
    end

    private

    def format_hash_as_string(hash)
      return nil if hash.empty?

      hash.map do |k, v|
        case v
        when Array
          "#{k}=#{v.join("+")}"
        else
          "#{k}=#{v}"
        end
      end.join(", ")
    end
  end
end
