require 'rails_helper'

describe Article do
  it { is_expected.to respond_to(:title) }
  it { is_expected.to respond_to(:body) }

  describe "title" do
    it "is unique" do
      article1 = Article.new(:title => "Example Article")
      article2 = Article.new(:title => "Example Article")

      article1.save

      expect(article2).not_to be_valid
    end
  end
end
