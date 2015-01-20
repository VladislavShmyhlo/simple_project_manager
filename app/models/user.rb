class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :projects, dependent: :destroy
  has_many :tasks, through: :projects
  has_many :comments, through: :tasks
  has_many :attachments, through: :comments
end
