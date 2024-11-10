class Routine < Sequel::Model
  plugin :validation_helpers
  plugin :timestamps, update_on_create: true

  def validate
    super
    validates_presence [:title, :frequency]
    validates_includes ['daily', 'weekly', 'monthly', 'quarterly', 'yearly'], :frequency
  end

  def reset_completion?
    return false unless active
    return false unless completed
    
    case frequency
    when 'daily'
      completed_at.to_date < Date.today
    when 'weekly'
      completed_at.to_date < Date.today && Date.today.wday == day_of_week
    when 'monthly'
      completed_at.to_date < Date.today && Date.today.day == day_of_month
    when 'quarterly'
      months = [1, 4, 7, 10]
      completed_at.to_date < Date.today && 
        Date.today.day == day_of_month && 
        months.include?(Date.today.month)
    when 'yearly'
      completed_at.to_date < Date.today && 
        Date.today.day == day_of_month && 
        Date.today.month == month
    end
  end
end 