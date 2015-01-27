require 'spec_helper'

feature 'project management', js: true do
  include_context 'user logged in'

  let(:project_name) { 'project name' }
  let(:task_name) { 'task name' }

  context 'when user has project' do
    background do
      find('.new-project-button button').click
      within '.new-project-form' do
        fill_in 'name', with: project_name
        find('button.save').click
      end
    end

    scenario "user creates task" do
      within '.new-task-form' do
        3.times do
          fill_in :description, with: task_name
          click_on 'Add Task'
        end
      end
      # TODO: expectation
    end
  end
end
