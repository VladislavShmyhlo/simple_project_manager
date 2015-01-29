FactoryGirl.define do
  factory :attachment do
    file fixture_file_upload('file.txt')
  end
end
