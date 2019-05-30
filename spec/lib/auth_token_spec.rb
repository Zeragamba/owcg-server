describe AuthToken do
  describe "::encode" do
    let(:data) {{"sample" => "value"}}

    it "encodes data into a JWT" do
      expect(AuthToken.encode(data)).to eq(JWT.encode(data, JWT_SECRET, JWT_ALGORITHM))
    end
  end

  describe "::decode" do
    let(:data) {{"sample" => "value"}}

    it "decodes a JWT into data" do
      token = JWT.encode(data, JWT_SECRET, JWT_ALGORITHM)
      expect(AuthToken.decode(token)).to eq(data)
    end

    context "when the token was not signed by the server" do
      it "raises a decode error" do
        token = JWT.encode(data, "Mr. Evil", JWT_ALGORITHM)
        expect{AuthToken.decode(token)}.to raise_error(JWT::DecodeError)
      end
    end

    context "when the token is not encrypted" do
      it "raises a decode error" do
        token = JWT.encode(data, JWT_SECRET, 'none')
        expect{AuthToken.decode(token)}.to raise_error(JWT::DecodeError)
      end
    end

    context "when the token is encrypted with a different algorithm" do
      it "raises a decode error" do
        token = JWT.encode(data, JWT_SECRET, 'HS256')
        expect{AuthToken.decode(token)}.to raise_error(JWT::DecodeError)
      end
    end
  end
end