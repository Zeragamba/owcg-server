class User < ApplicationRecord
  has_secure_password

  validates_uniqueness_of :username

  def as_json(options={})
    options[:except] ||= [:password_digest]
    super(options)
  end
end
