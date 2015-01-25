class Attachment < ActiveRecord::Base
  belongs_to :comment
  
  has_attached_file :file

  validates_attachment :file,
                       presence: true,
                       content_type: { content_type: /\A.*\/.*\Z/ },
                       size: { in: 0..10.megabytes }
end
