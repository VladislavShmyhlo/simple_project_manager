require 'spec_helper'

feature 'comment management', js: true do
  context 'when user has task' do
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
        click_on 'add new comment', disabled: true
      end
      expect(page).to have_no_selector('.comments-list .comment')
    end
  end

  context 'when user has comment' do
    include_context 'logged in user has comment'

    background do
      find('.task .description').click
    end

    scenario 'user deletes comment' do
      find('.comment-remove').click
      expect(page).to have_no_selector('.comments-list .comment')
    end

    scenario 'user uploads file' do
      within :attachmentForm do
        attach_file(:file, File.join(Rails.root, 'config.ru'))
      end
      expect(find('.attachment .name')).to have_content('config.ru')
    end
  end
end