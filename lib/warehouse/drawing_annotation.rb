module Warehouse
  class DrawingAnnotation < Annotation
    def self.from(classification, annotation_hash)
      # One drawing annotation hash will have multiple drawings inside. For
      # the purposes of the warehouse, we unwrap them and treat each element
      # as a seperate annotation.

      annotation_hash["value"].map do |value|
        new(classification, annotation_hash.merge("value" => value))
      end
    end

    def tool
      hash["value"]["tool"]
    end

    def tool_label
      tool_idx = hash["value"]["tool"]
      translate(task_definition["tools"][tool_idx]["label"])
    end

    def value
      nil
    end

    def marking
      val = hash.fetch("value")

      points = []

      if ["x", "y"].all? { |i| val.key?(i) }
        x = val.fetch("x")
        y = val.fetch("y")
        points << [x,y]
      end

      if ["x1", "y1", "x2", "y2"].all? { |i| val.key?(i) }
        points << [val.fetch("x1"), val.fetch("y1")]
        points << [val.fetch("x2"), val.fetch("y2")]
      end

      if val.key?("points")
        val.fetch("points").each { |point| points << [point["x"], point["y"]] }
      end

      points.map { |x,y| "(#{x.round(4)},#{y.round(4)})" }.join(" ")
    rescue
      STDERR.puts hash.inspect
      raise
    end

    def frame
      hash["value"]["frame"]
    end

    def details
      hash["value"]["details"].to_json
    end
  end
end
