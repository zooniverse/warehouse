require 'warehouse/annotation'
require 'warehouse/user'

module Warehouse
  class Classification
    attr_reader :event

    def initialize(event)
      @event = event
    end

    def to_row
      {
        id: id,
        event: Sequel.pg_jsonb(event),
        user_id: user.id,
        user_name: user.name,
        user_ip: user.ip_address,
        project_id: fetch("project_id"),
        workflow_id: fetch("workflow_id"),
        workflow_name: fetch("workflow_name"),
        workflow_version: fetch("workflow_version"),
        created_at: fetch("created_at"),
        updated_at: fetch("updated_at"),
        completed: fetch("completed"),
        gold_standard: fetch("gold_standard"),
        expert: fetch("expert")
      }
    end

    def id
      hash.fetch("id")
    end

    def annotations
      fetch("annotations").map { |annotation_hash| Annotation.new(self, annotation_hash) }
    end

    def subjects
      @subjects ||= subject_ids.map do |subject_id|
        attributes = linked.fetch("subjects", {}).find do |subject_data|
          subject_data.fetch("id") == subject_id
        end

        Subject.new(subject_id, attributes)
      end
    end

    def user
      User.new(self, {})
    end

    def user_id
      hash.fetch("links").fetch("user")
    end

    def workflow_id
      hash.fetch("links").fetch("workflow")
    end

    def subject_ids
      hash.fetch("links").fetch("subjects")
    end

    private

    def fetch(key)
      hash.fetch(key, nil)
    end

    def hash
      event.fetch("data")
    end

    def linked
      event.fetch("linked") { {} }
    end
  end
end
