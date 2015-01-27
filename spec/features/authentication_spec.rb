require 'spec_helper'

feature "authentication", js: true do
  let(:user) { FactoryGirl.create :user }

  background do
    user.confirmed_at = Time.now
    user.save
  end

  scenario "user logs in" do
    visit '/'
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    click_on "Log in"

    expect(page).to have_button('Add New Project')
    expect(current_path).to eq('/')
  end

  scenario "user fails to log in due to invalid data" do
    visit '/'
    fill_in "user_email", with: 'wrong@example.com'
    fill_in "user_password", with: '8digits!'
    click_on "Log in"

    expect(page).to have_content(/invalid email or password/i)
  end

  context "when logged in user" do
    include_context 'user logged in'

    scenario "signs out" do
      click_on "logout"
      expect(page).to have_content(/signed out successfully/i)
    end

    scenario 'changes password' do
      visit '/users/edit'
      fill_in 'user_password', with: new_password
      fill_in 'user_password_confirmation', with: new_password
      fill_in 'user_current_password', with: user.password
      click_on 'Update'

      expect(page).to have_button('Add New Project')
      expect(current_path).to eq('/')
    end
  end
end