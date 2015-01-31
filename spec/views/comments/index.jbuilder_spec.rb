require 'spec_helper'

describe "comments/index" do
  before(:each) do
    assign(:comments, [
      FactoryGirl.build(:comment, attachments: [FactoryGirl.build(:attachment)]),
      FactoryGirl.build(:comment, attachments: [FactoryGirl.build(:attachment)])
    ])

    render
  end

  it "renders comments json" do
    comments = JSON.parse(rendered)
    comments.each do |comment|
      expect(comment.keys).to eq(ExpectedKeys::COMMENT + ['attachments'])
      comment['attachments'].each do |attachment|
        expect(attachment.keys).to eq(ExpectedKeys::ATTACHMENT)
      end
    end
  end
end
