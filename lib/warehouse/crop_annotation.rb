module Warehouse
  class CropAnnotation < Annotation
    def value
      hash.fetch("value").to_json
    end
  end
end
