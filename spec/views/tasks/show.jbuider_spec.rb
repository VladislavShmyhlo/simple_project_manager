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
    expect(task.keys.sort).to eq((ExpectedKeys::TASK + ['comments', 'project']).sort)
    task['comments'].each do |comment|
      expect(comment.keys.sort).to eq((ExpectedKeys::COMMENT + ['attachments']).sort)
      comment['attachments'].each do |attachment|
        expect(attachment.keys.sort).to eq(ExpectedKeys::ATTACHMENT.sort)
      end
    end
  end
end
