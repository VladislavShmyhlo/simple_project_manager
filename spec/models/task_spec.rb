require 'spec_helper'

describe Task do
  subject(:task) { FactoryGirl.build(:task) }

  it "passes with valid description" do
    task.description = 'valid description'
    expect(task.valid?).to be true
  end

  it "fails with empty description" do
    task.description = ''
    expect(task.invalid?).to be true
  end

  it "should be saved" do
    expect {
      task.save
    }.to change(Task, :count).by(1)
  end

  it "has many comments" do
    expect {
      3.times { task.comments << FactoryGirl.build(:comment) }
      task.save
    }.to change(task.comments, :count).by(3)
  end

  it "should be destroyed with it's comments" do
    3.times { task.comments << FactoryGirl.build(:comment) }
    task.save
    ids = task.comments.map &:id
    expect {
      task.destroy
    }.to change(Comment.where(id: ids), :count).by(-3)
    expect(Comment.where(id: ids).count).to eq(0)
  end

  it "belongs to project" do
    project = FactoryGirl.create(:project)
    project.tasks << task
    expect(task.project).to eq(project)
  end
end
