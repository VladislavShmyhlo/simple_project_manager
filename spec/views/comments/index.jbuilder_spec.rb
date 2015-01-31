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
      expect(comment.keys.sort).to eq((ExpectedKeys::COMMENT + ['attachments']).sort)
      comment['attachments'].each do |attachment|
        expect(attachment.keys.sort).to eq(ExpectedKeys::ATTACHMENT.sort)
      end
    end
  end
end
