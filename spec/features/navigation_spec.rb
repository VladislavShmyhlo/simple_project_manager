require 'spec_helper'

feature 'navigation', js: true do
  include_context 'user logged in'

  let(:project_name) { 'project name' }

  scenario 'navigates to single project page' do
    # TODO: fix this terrible implementation
    find('.created-project .name a').click
    expect(current_url).to match(/\Ahttp\:\/\/127\.0\.0\.1\:\d+\/\#\/projects\/\d+\z/)
  end

  context 'when user navigated to sinle project page' do
    background do
      find('.created-project .name a').click
    end

    scenario 'navigates to single project page' do
      find('a.view-all').click
      expect(current_url).to match(/\Ahttp\:\/\/127\.0\.0\.1\:\d+\/\#\/\z/)
    end
  end
end