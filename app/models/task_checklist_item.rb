class TaskChecklistItem < Sequel::Model
  many_to_one :task
  
  plugin :validation_helpers
  plugin :timestamps, update_on_create: true

  def validate
    super
    validates_presence [:content, :task_id]
  end

  def before_create
    self.position ||= TaskChecklistItem.where(task_id: task_id).count
    super
  end
end 