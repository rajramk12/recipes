class Chef < ApplicationRecord
before_save {self.email = email.downcase}

VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
validates :chefname, presence: true,length: {maximum: 30}
validates :email, presence: true, length: { maximum: 255},
          format: {with: VALID_EMAIL_REGEX},uniqueness: {case_sensitive: false}

has_many :recipes, dependent: :destroy
has_secure_password
validates :password,presence: true, length: {minimum:6} , allow_nil: true
has_many :comments
has_many :messages, dependent: :destroy
end
