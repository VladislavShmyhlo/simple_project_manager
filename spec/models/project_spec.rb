require 'spec_helper'

describe Project do
  subject(:project) { FactoryGirl.build(:project) }

  it "passes with valid name" do
    project.name = 'valid name'
    expect(project.valid?).to be true
  end

  it "fails with short name" do
    project.name = 'x'
    expect(project.invalid?).to be true
  end

  it "fails with long name" do
    project.name = 'x'*81
    expect(project.invalid?).to be true
  end

  it "fails with empty name" do
    project.name = ''
    expect(project.invalid?).to be true
  end

  it "should be saved" do
    expect {
      project.save
    }.to change(Project, :count).by(1)
  end

  it "has many tasks" do
    expect {
      3.times { project.tasks << FactoryGirl.build(:task) }
      project.save
    }.to change(project.tasks, :count).by(3)
  end

  it "should be destroyed with it's tasks" do
    3.times { project.tasks << FactoryGirl.build(:task) }
    project.save
    ids = project.tasks.map &:id
    expect {
      project.destroy
    }.to change(Task.where(id: ids), :count).by(-3)
    expect(Task.where(id: ids).count).to eq(0)
  end
end
