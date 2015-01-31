require 'spec_helper'

describe "comments/show" do
  before(:each) do
    assign :comment,
           FactoryGirl.build(:comment,
                             attachments: [FactoryGirl.build(:attachment)])

    render
  end

  it "renders comment json" do
    comment = JSON.parse(rendered)
    expect(comment.keys.sort).to eq((ExpectedKeys::COMMENT + ['attachments']).sort)
    comment['attachments'].each do |attachment|
      expect(attachment.keys.sort).to eq((ExpectedKeys::ATTACHMENT).sort)
    end
  end
end
