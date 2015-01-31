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

  it 'fails with empty' do
    user.email = " "
    expect(user).to_not be_valid
  end
end
