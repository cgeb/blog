require "rails_helper"

RSpec.describe Article do
  describe "#search" do
    let!(:user) { User.create(name: "Chris", email: "chris@test.com", password: "password") }
    let!(:article_1) { Article.create(author_id: user.id, title: "Ruby", content: "RoR is fun to use.") }
    let!(:article_2) { Article.create(author_id: user.id, title: "Javascript Frameworks", content: "React, Vue, and Angular are popular") }
    let!(:article_3) { Article.create(author_id: user.id, title: "Elixir", content: "Becoming popular with the ruby community.") }

    it "returns items that match query" do
      expect(Article.search("Ruby")).to eq([article_1, article_3])
    end

    it "returns all items if query is blank" do
      expect(Article.search(nil)).to eq([article_1, article_2, article_3])
    end
  end
end
