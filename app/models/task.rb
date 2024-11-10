class Task < Sequel::Model
  many_to_one :area
  one_to_many :checklist_items, class: :TaskChecklistItem
  
  plugin :validation_helpers
  plugin :timestamps, update_on_create: true

  def validate
    super
    validates_presence [:title, :type, :area_id]
    validates_includes ['important', 'urgent'], :type
  end

  def before_create
    self.position ||= Task.where(area_id: area_id).count
    super
  end
end 