class Admin < ApplicationRecord
  # Include default devise modules.
  # :omniauthable, :confirmable :trackable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  validates :password, confirmation: true
end
