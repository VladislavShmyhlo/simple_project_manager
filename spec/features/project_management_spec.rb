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
    click_on '.new-project-button button'
    fill_in '.new-project-form input', with: 'new project name'
    click_on '.new-project-form button.save'
    expect(find('.project .name')).to have_content 'new project name'
  end
end