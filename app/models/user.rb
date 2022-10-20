class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :articles
  has_one_attached :avatar
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :email, uniqueness: true
  validates :username, uniqueness: true
  validates :avatar,   content_type: { in: %w[image/jpeg image/gif image/png],
                                      message: "must be a valid image format" },
            size:         { less_than: 5.megabytes,
                            message:   "should be less than 5MB" }
end
