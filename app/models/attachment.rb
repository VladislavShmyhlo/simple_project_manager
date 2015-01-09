class Attachment < ActiveRecord::Base
  belongs_to :comment
  
  has_attached_file :file  
  validates_attachment_content_type :file, :content_type => /\A.*\/.*\Z/
end
