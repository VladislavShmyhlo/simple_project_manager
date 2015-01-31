require 'spec_helper'

describe Users::OmniauthCallbacksController do
  subject { get 'facebook', {action: 'facebook'} }

  before :each do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  it 'signs user in' do
    User.should_receive(:from_omniauth).and_return(FactoryGirl.create(:user))
    subject { get 'facebook', {action: 'facebook'} }
    expect(response.status).to eq(302)
  end

  it 'redirects unsaved user to registration path' do
    User.should_receive(:from_omniauth).and_return(FactoryGirl.build(:user))
    expect(subject).to redirect_to(new_user_registration_url)
  end
end