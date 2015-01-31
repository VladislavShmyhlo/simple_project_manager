require 'spec_helper'

describe "attachments/show" do
  before(:each) do
    assign :attachment,
            FactoryGirl.build(:attachment)

    render
  end

  it "renders attachment json" do
    attachment = JSON.parse(rendered)
    expect(attachment.keys).to eq(ExpectedKeys::ATTACHMENT)
  end
end
