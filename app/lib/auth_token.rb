class AuthToken
  def self.encode(data)
    JWT.encode data, JWT_SECRET, JWT_ALGORITHM
  end

  def self.decode(token)
    decoded_token = JWT.decode token, JWT_SECRET, true, :algorithm => JWT_ALGORITHM
    decoded_token[0]
  end

  def self.for_user(user)
    AuthToken.encode({
      :user => {
        :username => user.username,
      },
    })
  end
end