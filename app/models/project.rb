class Project < ActiveRecord::Base
  belongs_to :user
  has_many :tasks, -> { order(:position) }, dependent: :destroy
  accepts_nested_attributes_for :tasks

  validates :name, presence: true, length: {minimum: 3, maximum: 80}
end