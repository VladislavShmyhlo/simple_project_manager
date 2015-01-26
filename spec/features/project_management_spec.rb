require 'spec_helper'

feature 'project management', js: true do
  let(:user) { FactoryGirl.create :user }

  background do
    user.confirmed_at = Time.now
    user.save

    visit '/'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Log in'
  end

  scenario 'user creates new project' do
    click_on /add new project/i
    within '.new-project-form' do
      fill_in 'name', with: 'new project name'
      find('button.save').click
    end
    expect(find('.project .name')).to have_content 'new project name'
  end
end