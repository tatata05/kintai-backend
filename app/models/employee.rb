class Employee < ApplicationRecord
  # Include default devise modules.
  # :omniauthable, :confirmable, :trackable,
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :shifts, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :name, presence: true
  VALID_PHONE_NUMBER_REGEX = /\A0[5789]0[-]?\d{4}[-]?\d{4}\z/
  validates :phone_number, format: { with: VALID_PHONE_NUMBER_REGEX }, uniqueness: true
  validates :emergency_phone_number, format: { with: VALID_PHONE_NUMBER_REGEX }
end
