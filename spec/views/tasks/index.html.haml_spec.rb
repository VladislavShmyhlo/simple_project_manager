require 'spec_helper'

describe "tasks/index" do
  before(:each) do
    assign(:tasks, [
      stub_model(Task,
        :description => "MyText",
        :completed => false,
        :project => nil
      ),
      stub_model(Task,
        :description => "MyText",
        :completed => false,
        :project => nil
      )
    ])
  end

  it "renders a list of tasks" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
