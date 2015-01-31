require 'spec_helper'

describe "attachments/index" do
  before(:each) do
    assign(:attachments, [
      FactoryGirl.build(:attachment),
      FactoryGirl.build(:attachment)
    ])

    render
  end

  it "renders attachments json" do
    attachments = JSON.parse(rendered)
    attachments.each do |attachment|
      expect(attachment.keys).to eq(ExpectedKeys::ATTACHMENT)
    end
  end
end
