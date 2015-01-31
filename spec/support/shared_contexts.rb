shared_context 'user exists' do
  let(:user) { FactoryGirl.create :user }
  background do
    user.confirmed_at = Time.now
    user.save
  end
end

shared_context 'user logs in' do
  background do
    visit '/'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Log in'
  end
end

shared_context 'user logged in' do
  include_context 'user exists'
  include_context 'user logs in'
end

shared_context 'logged in user has project' do
  include_context 'user exists'
  background do
    FactoryGirl.create :project, user: user
  end
  include_context 'user logs in'
end

shared_context 'logged in user has task' do
  include_context 'user exists'
  background do
    FactoryGirl.create :task,
        project: FactoryGirl.create(:project, user: user)
  end
  include_context 'user logs in'
end

shared_context 'logged in user has comment' do
  include_context 'user exists'
  background do
    FactoryGirl.create :comment,
        task: FactoryGirl.create(:task,
            project: FactoryGirl.create(:project, user: user))
  end
  include_context 'user logs in'
end

shared_context 'logged in user has attachment' do
  include_context 'user exists'
  background do
    FactoryGirl.create :attachment,
        comment: FactoryGirl.create(:comment,
            task: FactoryGirl.create(:task,
                project: FactoryGirl.create(:project, user: user)))
  end
  include_context 'user logs in'
end

shared_context 'valid session' do
  let(:user) { FactoryGirl.create :user }

  before :each do
    user.confirmed_at = Time.now
    user.save
    sign_in user
  end
end