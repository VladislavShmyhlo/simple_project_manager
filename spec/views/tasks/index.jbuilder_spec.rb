require 'spec_helper'

describe "tasks/index" do
  before(:each) do
    assign(
      :tasks, [
      FactoryGirl.build(:task),
      FactoryGirl.build(:task)
    ])

    render
  end

  it "renders tasks json" do
    tasks = JSON.parse(rendered)
    tasks.each do |task|
      expect(task.keys).to eq(ExpectedKeys::TASK)
    end
  end
end
