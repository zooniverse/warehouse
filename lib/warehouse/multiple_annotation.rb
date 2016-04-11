module Warehouse
  class MultipleAnnotation < Annotation
    def self.from(classification, annotation_hash)
      annotation_hash["value"].map do |value|
        SingleAnnotation.new(classification, annotation_hash.merge("value" => value))
      end
    end
  end
end
