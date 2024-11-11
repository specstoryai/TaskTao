class Area < Sequel::Model
  one_to_many :tasks
  
  plugin :validation_helpers
  plugin :timestamps, update_on_create: true

  def validate
    super
    validates_presence [:title, :color]
    validates_unique :title
  end

  def before_create
    self.position ||= Area.count
    self.active = true if active.nil?
    super
  end
end 