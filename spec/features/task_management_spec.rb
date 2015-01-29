require 'spec_helper'

feature 'project management', js: true do
  include_context 'user logged in'

  context 'when user has project' do
    background do
      find('.new-project-button button').click
      within '.new-project-form' do
        fill_in 'name', with: 'project name'
        find('button.save').click
      end
    end

    scenario "user creates task" do
      within '.new-task-form' do
        fill_in :description, with: 'task description'
        click_on 'Add Task'
      end
      # TODO: expectation
    end
  end
end
