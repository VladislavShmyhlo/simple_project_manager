require 'spec_helper'

feature 'navigation', js: true do
  let(:user) { FactoryGirl.create :user }
  let(:project_name) { 'project name' }

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

    scenario 'navigates to single project page' do
      find('.created-project .name a').click
      expect(page.execute_script("window.location.hash")).to match(/\A\#\/projects\/\d+\z/)
      expect(window.hash).to match(/\A\#\/projects\/\d+\z/)
    end
  end
end