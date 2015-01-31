require 'spec_helper'

feature 'project management', js: true do
  include_context 'user logged in'

  let(:project_name) { 'my new project' }
  let(:new_valid_name) { 'my new project name' }
  let(:new_invalid_name) { ' ' }

  feature 'project creation' do
    background do
      find('.new-project-button button').click
    end

    scenario 'user creates project' do
      within '.new-project-form' do
        fill_in :name, with: project_name
        find('button.save').click
      end
      expect(find('.created-project .name')).to have_content(project_name)
    end

    scenario 'user fails to create project due to validation' do
      within '.new-project-form' do
        fill_in :name, with: new_invalid_name
        find('button.save').click
      end
      expect(page).to have_no_selector '.created-project'
    end
  end

  context 'when user has project' do
    background do
      find('.new-project-button button').click
      within '.new-project-form' do
        fill_in :name, with: project_name
        find('button.save').click
      end
    end

    scenario 'user deletes project' do
      find('.created-project .remove').click
      expect(page).to have_no_content project_name
    end

    feature 'renaming' do
      scenario 'changes project name' do
        expect {
          find('.created-project .edit').click
          within '.project-name-form' do
            fill_in :name, with: new_valid_name
            find('button.save').click
          end
        }.to change{ find('.created-project .name').text }.from(project_name).to(new_valid_name)
      end

      scenario 'fails to change project name due to validation' do
        expect {
          find('.created-project .edit').click
          within '.project-name-form' do
            fill_in :name, with: new_invalid_name
            find('button.save').click
            sleep 1
          end
        }.to_not change(find('.created-project .name a', visible: false), :text)
      end

      scenario 'cancels project editing' do
        expect {
          find('.created-project .edit').click
          within '.project-name-form' do
            fill_in :name, with: new_invalid_name
          end
          find('.created-project .cancel').click
        }.to_not change{ find('.created-project .name a', visible: false).text }
      end
    end
  end
end