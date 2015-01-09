require 'spec_helper'

describe Project do
    # pending "add some examples to (or delete) #{__FILE__}"
  subject(:project) { FactoryGirl.build(:project) }

  it "has valid name" do
    project.name = 'some name'
    expect(project.valid?).to be_true
  end

  it "is invalid because of short name" do
    project.name = 'do'
    expect(project.invalid?).to be_true
  end

  it "is invalid because of long name" do
    project.name = 'a'*81
    expect(project.invalid?).to be_true
  end

  it "is invalid because of empty name" do
    project.name = ''
    expect(project.invalid?).to be_true
  end
end
