FactoryGirl.define do
  factory :attachment do
    file_file_name { 'file.txt' }
    file_content_type { 'text/plain' }
    file_file_size { 1.megabyte }

  	## that is stil does not seem to work properly
    # file { fixture_file_upload(File.join('files', 'file.txt'), 'text/plain') }
    ## fix to force rspec to close files after reading
    # after_create do |file, proxy|
    #   proxy.file.close
    # end
  end
end
