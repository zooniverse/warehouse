require 'warehouse/annotations'
require 'warehouse/user'
require 'warehouse/workflow'
require 'warehouse/workflow_content'

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
        project_id: hash.fetch("links").fetch("project"),
        workflow_id: hash.fetch("links").fetch("workflow"),
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
      fetch("annotations").flat_map do |annotation_hash| 
        Annotations.from(self, annotation_hash)
      end
    end

    def subjects
      @subjects ||= hash["links"]["subjects"].map do |subject_id|
        Subject.new(self, find_linked("subjects", subject_id))
      end
    end

    def project
      @project ||= Project.new(self, find_linked("projects", hash["links"]["project"]))
    end

    def workflow
      @workflow ||= Workflow.new(self, find_linked("workflows", hash["links"]["workflow"]))
    end

    def workflow_content
      @workflow_content ||= WorkflowContent.new(self, find_linked("workflow_contents", hash["links"]["workflow_content"]))
    end

    def user
      @user ||= User.new(self, {})
    end

    def find_task(task)
      workflow.find_task(task)
    end

    def translate(key)
      return unless key
      workflow_content.translate(key)
    rescue
      binding.pry
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

    def find_linked(linked_type, linked_id)
      linked_models = linked.fetch(linked_type, [])
      linked_models.find { |linked_model| linked_model.fetch("id") == linked_id }
    end
  end
end
