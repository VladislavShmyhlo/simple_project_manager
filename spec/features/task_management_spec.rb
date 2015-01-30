require 'spec_helper'

  include Warden::Test::Helpers
feature 'task management', js: true do
  include_context 'user logged in'
  let(:description) { 'task description' }

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
        fill_in :description, with: description
        click_on 'Add Task'
      end
      expect(find('.task .description')).to have_content(description)
    end
  end
end
