require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.build(:user) }

  it 'pases with valid email and confirmed password' do
    expect(user).to be_valid
  end

  it 'fails with empty email' do
    user.email = " "
    expect(user).to_not be_valid
  end

  it 'pases with provider is set and empty email' do
    user.email = " "
    user.provider = 'facebook'
    expect(user).to be_valid
  end

  it 'fails with bad email' do
    user.email = "random string"
    expect(user).to_not be_valid
  end

  it 'fails with already taken email' do
    user.save
    new_user = FactoryGirl.build(:user, email: user.email)
    expect(new_user).to_not be_valid
  end

  it 'fails with empty password' do
    user = User.new(email: 'test@example.com', password: ' ')
    expect(user).to_not be_valid
  end

  it 'fails with short password' do
    user = User.new(email: 'test@example.com', password: 'pass')
    expect(user).to_not be_valid
  end

  it 'fails with bad password confirmation' do
    user = User.new(email: 'test@example.com',
                    password: 'password',
                    password_confirmation: 'pass')
    expect(user).to_not be_valid
  end

  it 'creates user from omniauth data' do
    auth_data = double({
      provider: 'facebook',
      uid: '123456789',
      info: double(email: 'test@example.com')
    })
    user = User.from_omniauth(auth_data)
    expect(user).to be_persisted
  end
end
