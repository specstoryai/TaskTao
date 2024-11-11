require 'spec_helper'

RSpec.describe Area do
  describe "business rules" do
    it "maintains task order within the area" do
      area = create(:area)
      task1 = create(:task, area: area, position: 0)
      task2 = create(:task, area: area, position: 1)
      
      expect(area.tasks.order(:position).map(&:id)).to eq([task1.id, task2.id])
    end

    it "only shows active areas in capture mode" do
      active_area = create(:area, active: true)
      inactive_area = create(:area, active: false)
      
      areas = Area.where(active: true)
      expect(areas).to include(active_area)
      expect(areas).not_to include(inactive_area)
    end
  end
end 