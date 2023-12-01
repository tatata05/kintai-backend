class Admin < ApplicationRecord
  # Include default devise modules.
  # omniauth はSNS認証機能作成時に必要。
  # trackabele はログイン回数などの情報を保持、更新するのに必要らしい
  # :omniauthable, :confirmable :trackable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  validates :name, presence: true
end
