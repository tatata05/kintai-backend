class Admin < ApplicationRecord
  # Include default devise modules.
  # omniauth はSNS認証機能作成時に必要。
  # trackabele はログイン回数などの情報を保持、更新するのに必要らしい
  # :omniauthable, :confirmable :trackable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  # deviseでpassword_confimationが適切に動かないため、deviseに依存しない。
  validates :password, confirmation: true
end
