require 'spec_helper'

feature 'project management', js: true do
  let(:user) { FactoryGirl.create :user }
  let(:project_name) { 'project name' }
  let(:task_name) { 'task name' }
  background do
    user.confirmed_at = Time.now
    user.save

    visit '/'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Log in'
  end

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
