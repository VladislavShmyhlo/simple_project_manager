class Project < ActiveRecord::Base
  has_many :tasks

  validates :name, presence: true, length: {minimum: 3}
end
