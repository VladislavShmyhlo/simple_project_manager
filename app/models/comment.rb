class Comment < ActiveRecord::Base
  belongs_to :task, touch: :updated_at
  has_many :attachments, dependent: :destroy

  validates :body, presence: true
end
