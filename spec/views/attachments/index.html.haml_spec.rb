require 'spec_helper'

describe "attachments/index" do
  before(:each) do
    assign(:attachments, [
      FactoryGirl.build(:attachment),
      FactoryGirl.build(:attachment)
    ])

    render
  end

  it "renders a list of attachments" do
    expected_keys = [
      :id,
      :file,
      :file_file_name,
      :file_file_size,
      :file_content_type,
      :updated_at,
      :created_at
    ]
    res = rendered.to_json
    res.each do |attachment|
      expect(attachment.keys).to eq(expected_keys)
    end
  end
end
