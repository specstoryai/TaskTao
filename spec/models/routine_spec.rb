RSpec.describe Routine do
  describe "completion reset rules" do
    let(:routine) { create(:routine, completed: true, completed_at: Time.now) }

    context "daily routine" do
      before { routine.update(frequency: 'daily') }

      it "resets when completed yesterday" do
        routine.update(completed_at: Date.today - 1)
        expect(routine.reset_completion?).to be true
      end

      it "doesn't reset when completed today" do
        expect(routine.reset_completion?).to be false
      end
    end

    context "weekly routine" do
      before do 
        routine.update(
          frequency: 'weekly',
          day_of_week: Date.today.wday
        )
      end

      it "resets on the correct day of week" do
        routine.update(completed_at: Date.today - 7)
        expect(routine.reset_completion?).to be true
      end

      it "doesn't reset on other days" do
        routine.update(day_of_week: (Date.today.wday + 1) % 7)
        expect(routine.reset_completion?).to be false
      end
    end
  end
end 