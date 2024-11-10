Sequel.migration do
  change do
    create_table(:areas) do
      primary_key :id
      String :title, null: false
      String :description
      String :color, null: false
      Boolean :active, default: true
      Integer :position
      DateTime :created_at
      DateTime :updated_at
    end

    create_table(:tasks) do
      primary_key :id
      foreign_key :area_id, :areas
      String :title, null: false
      String :description
      String :type, null: false # 'important' or 'urgent'
      Boolean :for_today, default: false
      Boolean :completed, default: false
      DateTime :completed_at
      Integer :position
      DateTime :created_at
      DateTime :updated_at
    end

    create_table(:routines) do
      primary_key :id
      String :title, null: false
      String :description
      String :frequency # daily, weekly, monthly, quarterly, yearly
      Integer :day_of_week # 0-6 for weekly
      Integer :day_of_month # 1-31 for monthly
      Integer :month # 1-12 for yearly
      Boolean :active, default: true
      Boolean :completed, default: false
      DateTime :completed_at
      DateTime :created_at
      DateTime :updated_at
    end

    create_table(:task_checklist_items) do
      primary_key :id
      foreign_key :task_id, :tasks
      String :content, null: false
      Boolean :completed, default: false
      Integer :position
      DateTime :created_at
      DateTime :updated_at
    end
  end
end 