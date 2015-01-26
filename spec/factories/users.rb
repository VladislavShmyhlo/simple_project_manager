FactoryGirl.define do
  factory :user do
    email 'valid@mail.com'
    password 'password'
    confirmed_at Time.now
  end
end
