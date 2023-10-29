class Admin < ApplicationRecord
  # Include default devise modules.
  # :omniauthable, :confirmable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User
end
