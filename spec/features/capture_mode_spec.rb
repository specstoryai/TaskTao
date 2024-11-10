RSpec.describe "Capture Mode" do
  let!(:area) { create(:area) }

  it "creates a task with keyboard shortcuts" do
    post "/tasks", {
      task: {
        title: "New task",
        area_id: area.id,
        type: "important"
      }
    }
    
    expect(last_response.status).to eq(200)
    expect(Task.last.title).to eq("New task")
    expect(Task.last.area).to eq(area)
  end

  it "remembers last used area" do
    post "/tasks", {
      task: {
        title: "Task in area",
        area_id: area.id,
        type: "important"
      }
    }
    
    get "/capture"
    expect(last_response.body).to include("selected") # Area should be pre-selected
  end
end 