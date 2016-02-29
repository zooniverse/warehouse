Sequel.migration do
  change do
    create_table :classifications do
      primary_key :id
      column :event, :jsonb, text: true

      String   :user_id
      String   :user_name
      String   :user_ip
      Integer  :project_id
      Integer  :workflow_id
      String   :workflow_name
      String   :workflow_version
      DateTime :created_at
      DateTime :updated_at
      String   :completed
      String   :gold_standard
      String   :expert
      String   :subject_id
    end

    create_table :annotations do
      foreign_key :classification_id, :classifications, on_delete: :cascade
      
      String  :task
      String  :task_label
      String  :task_type
      String  :tool
      String  :tool_label
      String  :value
      String  :value_label
      String  :choice
      String  :answers
      String  :filters
      String  :marking
      String  :frame
      String  :details
    end
  end
end
