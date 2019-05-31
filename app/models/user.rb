class User < ApplicationRecord
  has_secure_password

  validates :username, presence: true, uniqueness: true

  def as_json(options={})
    options[:except] ||= [:password_digest]
    super(options)
  end
end
