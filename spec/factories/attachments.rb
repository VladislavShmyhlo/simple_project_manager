FactoryGirl.define do
  factory :attachment do
    file { fixture_file_upload('file.txt') }

    # fix to force rspec to close files after reading
    after_create do |file, proxy|
      proxy.file.close
    end
  end
end
