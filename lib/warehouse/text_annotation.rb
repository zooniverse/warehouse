module Warehouse
  class TextAnnotation < Annotation
    def value(annotation)
      annotation.fetch("value").to_s
    end
  end
end
