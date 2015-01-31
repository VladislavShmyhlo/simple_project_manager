require 'spec_helper'

feature 'navigation', js: true do
  include_context 'logged in user has task'

  let(:project_name) { 'project name' }

  scenario 'navigates to single project page' do
    find('.created-project .name a').click
    expect(URI(current_url).fragment).to match /\A\/projects\/\d+\z/
  end

  context 'when user navigated to sinle project page' do
    background do
      find('.created-project .name a').click
    end

    scenario 'navigates to all projects' do
      find('a.view-all').click
      expect(URI(current_url).fragment).to eq '/'
    end

    scenario 'navigates to single task page' do
      find('.task .description').click
      expect(URI(current_url).fragment).to match /\A\/projects\/\d+\/tasks\/\d+\z/
    end

    context 'when user navigated to sinle task page' do
      background do
        find('.task .description').click
      end

      scenario 'navigates back to single project page' do
        find('a.view-project').click
        expect(URI(current_url).fragment).to match /\A\/projects\/\d+\z/
      end
    end
  end
end