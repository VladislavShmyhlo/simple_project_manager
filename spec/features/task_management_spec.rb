require 'spec_helper'

feature 'task management', js: true do
  let(:description) { 'my new task' }
  let(:new_description) { 'my new task description' }
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
        expect(page).to have_no_selector('.tasks-list > .task')
      end
    end
  end

  context 'when user has task' do
    include_context 'logged in user has task'

    feature 'renaming' do
      scenario 'changes task description' do
        expect {
          find('.task .edit').click
          within '.task-description-form' do
            fill_in :description, with: new_description
            find('button.save').click
          end
        }.to change{ find('.task a.description').text}.to(new_description )
      end

      it 'fails to change description due to validation' do
        expect {
          find('.task .edit').click
          within '.task-description-form' do
            fill_in :description, with: invalid_description
            find('button.save').click
          end
        }.to_not change{ find('.task a.description', visible: false).text }
      end

      scenario 'cancels task editing' do
        expect {
          find('.task .edit').click
          within '.task-description-form' do
            fill_in :description, with: invalid_description
            find('.cancel').click
          end
        }.to_not change{ find('.task a.description', visible: false).text }
      end
    end

    scenario 'user deletes task' do
      find('.task .remove').click
      expect(page).to have_no_selector('.tasks-list > .task')
    end

    scenario 'sets deadline' do
      within '.task' do
        find('.ui-datepicker-trigger').click
      end
      first('#ui-datepicker-div .ui-state-default', text: '7').click
      find('.task .description').click
      expect(find('.dates .deadline')).to have_content('7')
    end

    scenario 'sets completion status' do
      expect {
        within '.task' do
          find('.completed label').click
        end
      }.to change { page.has_css?('.task.done') }.from(false).to(true)
    end

    pending "sets priority through drag'n'drop" do
      fn = -> { within '.new-task-form' do
        fill_in :description, with: description
        click_on 'Add Task'
      end }
      fn.call
      sleep(1)
      fn.call
      first = first('.tasks-list > .task .handle')
      last = find('.tasks-list > .task:last-child .handle')
      expect {
        first.drag_to(last)
      }.to change { first('.tasks-list > .task')[:'data-id'] }
    end
  end
end
