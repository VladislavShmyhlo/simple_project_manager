require 'spec_helper'

describe "tasks/edit" do
  before(:each) do
    @task = assign(:task, stub_model(Task,
      :description => "MyText",
      :completed => false,
      :project => nil
    ))
  end

  it "renders the edit task form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", task_path(@task), "post" do
      assert_select "textarea#task_description[name=?]", "task[description]"
      assert_select "input#task_completed[name=?]", "task[completed]"
      assert_select "input#task_project[name=?]", "task[project]"
    end
  end
end
