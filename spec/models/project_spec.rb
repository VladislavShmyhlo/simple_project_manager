require 'spec_helper'

describe Project do
  subject(:project) { FactoryGirl.build(:project) }

  it "passes with valid name" do
    project.name = 'some name'
    expect(project.valid?).to be true
  end

  it "fails with short name" do
    project.name = 'do'
    expect(project.invalid?).to be true
  end

  it "fails with long name" do
    project.name = 'a'*81
    expect(project.invalid?).to be true
  end

  it "fails with empty name" do
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

  it "should be saved" do
    expect {
      project.save
    }.to change(Project, :count).by(1)
  end

  # it  'fails with empty name' do
  #   project.name = ''
  #   pending 'tst' do
  #     xau
  #     expect(project.invalid?).to be true
  #   end
  # end
end
