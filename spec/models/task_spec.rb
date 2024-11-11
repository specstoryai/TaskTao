require 'spec_helper'

RSpec.describe Task do
  describe "business rules" do
    it "can only be important or urgent" do
      task = build(:task, type: 'other')
      expect(task).not_to be_valid
      expect(task.errors[:type]).to include('is not included in the list')
    end

    it "must belong to an area" do
      task = build(:task, area: nil)
      expect(task).not_to be_valid
      expect(task.errors[:area_id]).to include('is not present')
    end

    it "tracks completion timestamp" do
      task = create(:task, completed: false)
      expect(task.completed_at).to be_nil
      
      task.update(completed: true)
      expect(task.completed_at).not_to be_nil
    end
  end
end 