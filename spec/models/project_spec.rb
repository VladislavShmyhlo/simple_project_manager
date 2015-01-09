require 'spec_helper'

describe Project do
  subject(:project) { FactoryGirl.build(:project) }

  it "has valid name" do
    project.name = 'some name'
    expect(project.valid?).to be true
  end

  it "is invalid because of short name" do
    project.name = 'do'
    expect(project.invalid?).to be true
  end

  it "is invalid because of long name" do
    project.name = 'a'*81
    expect(project.invalid?).to be true
  end

  it "is invalid because of empty name" do
    project.name = ''
    expect(project.invalid?).to be true
  end

  it "should be destroyed with it's tasks" do
    project.tasks.build([{},{},{}])
    project.save
    ids = project.tasks.map &:id
    project.destroy
    expect(Task.where(id: ids).count).to eq(0)
  end
end
