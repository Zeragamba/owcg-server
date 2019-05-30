class AuthToken
  def self.encode(data)
    JWT.encode data, JWT_SECRET, JWT_ALGORITHM
  end

  def self.decode(token)
    decoded_token = JWT.decode token, JWT_SECRET, true, :algorithm => JWT_ALGORITHM
    return decoded_token[0]
  end
end