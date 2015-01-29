require 'spec_helper'

describe Comment do
  subject(:comment) { FactoryGirl.build(:comment) }

  let(:attachment) { FactoryGirl.build :attachment }

  it "passes with valid body" do
    comment.body = 'valid body'
    expect(comment.valid?).to be true
  end

  it "fails with empty body" do
    comment.body = ''
    expect(comment.invalid?).to be true
  end

  it "should be saved" do
    expect {
      comment.save
    }.to change(Comment, :count).by(1)
  end

  it "has many attachments" do
    expect {
      3.times { comment.attachments << attachment }
      comment.save
    }.to change(comment.attachments, :count).by(3)
  end

  it "should be destroyed with it's attachments" do
    # TODO: fix this on all specs
    3.times { comment.attachments << attachment }
    comment.save
    expect {
      comment.destroy
    }.to change(Attachment.where(comment_id: comment.to_param), :count).by(-3)
    expect(Attachment.where(comment_id: comment.to_param).count).to eq(0)
  end

  it "belongs to task" do
    task = FactoryGirl.create(:task)
    task.comments << comment
    expect(comment.task).to eq(task)
  end
end
