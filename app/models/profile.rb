class Profile < ApplicationRecord
  belongs_to :user
  VALID_PHONE_REGEX = /\A\d[0-9]{9}\z/.freeze
  validates :first_name, length:
                  {maximum: Settings.model.profile.length_digit_50},
                  allow_blank: true
  validates :last_name, length:
                  {maximum: Settings.model.profile.length_digit_50},
                  allow_blank: true
  validates :address, length:
                  {maximum: Settings.model.profile.length_digit_255},
                  allow_blank: true
  validates :country, length:
                  {maximum: Settings.model.profile.length_digit_255},
                  allow_blank: true
  validates :phone, presence: true, format: {with: VALID_PHONE_REGEX},
                    allow_blank: true
  enum gender: {female: false, male: true}
end
