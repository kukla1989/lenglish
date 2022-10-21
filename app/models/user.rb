class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :articles
  has_one_attached :avatar do |attachable|
    attachable.variant :mini, resize_to_limit: [50, 50];
    attachable.variant :middle, resize_to_limit: [100, 100]

  end
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :email, uniqueness: true
  validates :username, uniqueness: true
  validates :avatar,   content_type: { in: %w[image/jpeg image/gif image/png],
                                      message: "must be a valid image format" },
            size:         { less_than: 5.megabytes,
                            message:   "should be less than 5MB" }
end
