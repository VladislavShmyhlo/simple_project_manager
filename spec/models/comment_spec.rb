require 'spec_helper'

describe Comment do
  include_context 'with file'

  subject(:comment) { FactoryGirl.build(:comment) }

  let(:attachment) { FactoryGirl.build :attachment, file: file }

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
      # TODO: attachment implementation should be fixed
      3.times { comment.attachments << Attachment.new(file: File.open('/home/shmyhlo/Desktop/test.rb')) }
      comment.save
    }.to change(comment.attachments, :count).by(3)
  end

  it "should be destroyed with it's attachments" do
    # TODO: attachment implementation should be fixed
    3.times { comment.attachments << Attachment.new(file: File.open('/home/shmyhlo/Desktop/test.rb')) }
    comment.save
    ids = comment.attachments.map &:id
    expect {
      comment.destroy
    }.to change(Attachment.where(id: ids), :count).by(-3)
    expect(Attachment.where(id: ids).count).to eq(0)
  end

  it "belongs to task" do
    task = FactoryGirl.create(:task)
    task.comments << comment
    expect(comment.task).to eq(task)
  end
end
