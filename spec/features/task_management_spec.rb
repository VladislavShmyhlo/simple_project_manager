require 'spec_helper'

feature 'task management', js: true do
  let(:description) { 'my new task' }
  let(:invalid_description) { ' ' }

  context 'when user has project' do
    include_context 'logged in user has project'

    feature "task creation" do
      scenario "user creates task" do
        within '.new-task-form' do
          fill_in :description, with: description
          click_on 'Add Task'
        end
        expect(find('.task .description')).to have_content(description)
      end

      scenario 'user fails to create task due to validation' do
        within '.new-task-form' do
          fill_in :description, with: invalid_description
        end
        expect(page).to have_button('Add Task', disabled: true)
      end
    end
  end

  context 'when user has task' do
    include_context 'logged in user has task'

    scenario 'user deletes task' do
      find('.task .remove').click
      expect(page).to have_no_selector('.tasks-list > .task')
    end
  end
end
