require 'spec_helper'

describe Attachment do
  include_context 'with file'

  subject(:attachment) do
    FactoryGirl.build :attachment, file: file
  end

  it "should be saved" do
    expect {
      attachment.save
    }.to change(Attachment, :count).by(1)
  end

  it "belongs to comment" do
    comment = FactoryGirl.create(:comment)
    comment.attachments << attachment
    expect(attachment.comment).to eq(comment)
  end

  it "has attached file" do
    expect(attachment).to have_attached_file(:file)
  end

  it "validates attached file presence" do
    expect(attachment).to validate_attachment_presence(:file)
  end

  it "validates attached file content type" do
    pending "has no content type validation"
    expect(attachment).to validate_attachment_content_type(:file)
                       # .allowing('image/png', 'image/gif')
                       # .rejecting('text/plain', 'text/xml')
  end

  it "validates attached file size" do
    expect(attachment).to validate_attachment_size(:file).
                           less_than(10.megabytes)
  end
end
