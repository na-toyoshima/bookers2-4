class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

        validates :name, presence: true, length: { minimum: 2, maximum: 20 }
        validates :introduction, length: { maximum: 50 }
        has_many :books, dependent: :destroy
        attachment :profile_image

        has_many :relationships
        has_many :followings, through: :relationships, source: :follow
        has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
        has_many :followers, through: :reverse_of_relationships, source: :user

end
