require 'spec_helper'

describe "tasks/show" do
  before(:each) do
    assign :task,
      FactoryGirl.build(:task,
        project: FactoryGirl.build(:project),
        comments: [FactoryGirl.build(:comment,
          attachments: [FactoryGirl.build(:attachment)])])



    render
  end

  it "renders task json" do
    task = JSON.parse(rendered)
    expect(task.keys).to eq(ExpectedKeys::TASK + ['comments', 'project'])
    task['coments'].each do |comment|
      expect(comment.keys).to eq(ExpectedKeys::COMMENT + ['attachments'])
      comment['attachments'].each do |attachment|
        expect(attachment.keys).to eq(ExpectedKeys::ATTACHMENT)
      end
    end
  end
end
