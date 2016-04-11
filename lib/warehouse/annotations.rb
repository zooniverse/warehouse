require 'warehouse/annotation'
require 'warehouse/single_annotation'
require 'warehouse/multiple_annotation'
require 'warehouse/drawing_annotation'
require 'warehouse/survey_annotation'
require 'warehouse/text_annotation'
require 'warehouse/crop_annotation'

module Warehouse
  class Annotations
    def self.from(classification, annotation_hash)
      task = classification.find_task(annotation_hash["task"])
      
      klass = case task["type"]
      when "single"   then SingleAnnotation
      when "multiple" then MultipleAnnotation
      when "drawing"  then DrawingAnnotation
      when "survey"   then SurveyAnnotation
      when "text"     then TextAnnotation
      when "crop"     then CropAnnotation
      else                 Annotation
      end

      klass.from(classification, annotation_hash)
    end
  end
end
