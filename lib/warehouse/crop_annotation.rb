module Warehouse
  class CropAnnotation < Annotation
    def value(annotation)
      annotation.fetch("value").to_json
    end
  end
end
