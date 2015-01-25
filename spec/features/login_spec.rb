require 'spec_helper'

feature "login", js: true do
  scenario "user logs in" do
    visit '/'
    fill_in "user_email", with: "root@root.root"
    fill_in "user_password", with: "rootroot"
    click_on "Log in"

    expect(page).to have_content("project")
  end
end