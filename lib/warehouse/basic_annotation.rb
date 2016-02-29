module Warehouse
  class Annotation
    COLUMNS = %i(task task_label task_type tool tool_label value value_label choice answers filters marking frame details)

    def self.format(annotation, task_definition: {}, translations: {})
      new(task_definition: task_definition, translations: translations).format(annotation)
    end

    attr_reader :translations, :task_definition

    def initialize(task_definition: {}, translations: {})
      @task_definition = task_definition || {}
      @translations = translations
    end

    def format(annotation)
      COLUMNS.each_with_object({}) do |column, hash|
        hash[column] = public_send(column, annotation)
      end
    end

    private

    def translate(string)
      @translations[string]
    end
  end
end
