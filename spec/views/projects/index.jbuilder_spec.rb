require 'spec_helper'

describe "projects/index" do
  before(:each) do
    assign(:projects, [
      FactoryGirl.build(:project, tasks: [FactoryGirl.build(:task)]),
      FactoryGirl.build(:project, tasks: [FactoryGirl.build(:task)])
    ])

    render
  end

  it "renders projects json" do
    projects = JSON.parse(rendered)
    projects.each do |project|
      expect(project.keys.sort).to eq((ExpectedKeys::PROJECT + ['tasks']).sort)
      project['tasks'].each do |task|
        expect(task.keys.sort).to eq(ExpectedKeys::TASK.sort)
      end
    end
  end
end
