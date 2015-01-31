require 'spec_helper'

describe "projects/show" do
  before(:each) do
    assign :project,
           FactoryGirl.build(:project, tasks: [FactoryGirl.build(:task)])

    render
  end

  it "renders project json" do
    project = JSON.parse(rendered)
    expect(project.keys).to eq(ExpectedKeys::PROJECT + ['tasks'])
    project['tasks'].each do |task|
      expect(task.keys).to eq(ExpectedKeys::TASK)
    end
  end
end
