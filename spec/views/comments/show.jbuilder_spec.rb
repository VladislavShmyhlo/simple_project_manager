require 'spec_helper'

describe "comments/show" do
  before(:each) do
    assign :comment,
           FactoryGirl.build(:comment,
                             attachments: [FactoryGirl.build(:attachment)])

    render
  end

  pending "renders comment json" do
    comment = JSON.parse(rendered)
    expect(comment.keys).to eq(ExpectedKeys::COMMENT + ['attachments'])
    comment['attachments'].each do |attachment|
      expect(attachment.keys).to eq(ExpectedKeys::ATTACHMENT)
    end
  end
end
