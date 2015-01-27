shared_context 'user logged in' do
  let(:new_password) { '8digits!' }

  background do
    visit '/'
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    click_on "Log in"
  end
end