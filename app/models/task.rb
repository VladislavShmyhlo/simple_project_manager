class Task < ActiveRecord::Base
  belongs_to :project
  has_many :comments, -> { order(:updated_at) }, dependent: :destroy
end