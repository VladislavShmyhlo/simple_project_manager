require 'spec_helper'

feature "loin", js: true do
  scenario "user login" do
    visit '/'
    fill_in "user_email", with: "root@root.root"
    fill_in "user_password", with: "rootroot"
    click_on "Log in"

    expect(page).to have_content("project")
    # expect(page).to have_content("Baked Brussel Sprouts")
  end
end