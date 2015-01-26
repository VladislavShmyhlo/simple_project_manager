require 'spec_helper'

feature 'user manages projects', js: true do
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
    find('.new-project-button button').click
    within '.new-project-form' do
      fill_in :name, with: 'new project name'
      find('button.save').click
    end
    expect(find('.project .name')).to have_content 'new project name'
  end

  context 'when user has project' do
    background do
      find('.new-project-button button').click
      within '.new-project-form' do
        fill_in 'name', with: 'new project name'
        find('button.save').click
      end
    end

    scenario 'user deletes project' do
      find('.project .remove').click
      expect(page).to have_no_selector '.project'
    end

    scenario 'user changes project name' do
      expect {
        find('.project .edit').click
        within '.project-name-form' do
          fill_in :name, with: 'new name'
          find('button.save').click
        end
      }.to change{ find('.project .name').text }.from('new project name').to('new name')
    end
  end
end