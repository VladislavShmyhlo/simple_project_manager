require 'spec_helper'

include Warden::Test::Helpers
Warden.test_mode!

feature "authentication", js: true do
  let(:user) { FactoryGirl.create :user }
  background do
    user.confirmed_at = Time.now
    user.save
  end
  scenario "user logs in" do
    login_as(user, :scope => :user)
    # visit '/'
    # fill_in "user_email", with: user.email
    # fill_in "user_password", with: user.password
    # click_on "Log in"

    expect(page).to have_content("create new project")
  end
end