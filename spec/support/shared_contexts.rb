shared_context 'user logged in' do
  let(:user) { FactoryGirl.create :user }

  background do
    user.confirmed_at = Time.now
    user.save

    visit '/'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Log in'
  end
end

shared_context 'valid session' do
  let(:user) { FactoryGirl.create :user }

  before :each do
    user.confirmed_at = Time.now
    user.save
    sign_in user
  end
end

shared_context 'with file' do
  dir = "#{Rails.root}/spec/test_files"
  filepath = File.join dir, 'test.txt'

  before :each do
    FileUtils.mkdir dir unless Dir.exist? dir
    File.open(filepath, 'a') do |f|
      f.puts Time.now.to_s
    end
  end

  let(:filepath) { filepath }
  let(:file) { File.open filepath }
end