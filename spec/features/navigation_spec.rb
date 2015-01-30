require 'spec_helper'

feature 'navigation', js: true do
  include_context 'user logged in'

  let(:project_name) { 'project name' }

  context 'when user has project' do
    background do
      find('.new-project-button button').click
      within '.new-project-form' do
        fill_in 'name', with: project_name
        find('button.save').click
      end
    end

    context 'when user on single project page' do
      background do
        find('.created-project .name a').click
      end

      scenario 'navigates to single project page' do
        # TODO: fix this terrible implementation
        expect(current_url).to match(/\Ahttp\:\/\/127\.0\.0\.1\:\d+\/\#\/projects\/\d+\z/)
      end

      scenario 'navigates to single project page' do
        find('a.view-all').click
        expect(current_url).to match(/\Ahttp\:\/\/127\.0\.0\.1\:\d+\/\#\/\z/)
      end
    end
  end
end