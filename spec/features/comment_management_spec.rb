require 'spec_helper'

feature 'comment management', js: true do
  include_context 'logged in user has task'

  let(:body) { 'my new comment' }

  scenario 'creates comment' do
    find('.task .description').click
    within '.new-comment-form' do
      fill_in :body, with: body
      click_on 'add new comment'
    end
    expect(find('.comments-list .comment')).to have_content(body)
  end

  scenario 'fails to create comment due to validation' do
    find('.task .description').click
    within '.new-comment-form' do
      fill_in :body, with: ' '
      click_on 'add new comment'
    end
    expect(page).to have_no_selector('.comments-list .comment')
  end

  context 'when user has comment' do
    include_context 'logged in user has comment'


  end
end