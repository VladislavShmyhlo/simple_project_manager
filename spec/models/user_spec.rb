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

  it 'fails with bad email' do
    user.email = "random string"
    expect(user).to_not be_valid
  end

  it 'fails with already taken email' do
    user.save
    new_user = FactoryGirl.build(:user, email: user.email)
    expect(new_user).to_not be_valid
  end
end
