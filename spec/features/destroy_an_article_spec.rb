require "support/login_helper"
require "rails_helper"

RSpec.configure do |c|
  c.include LoginHelper
end

RSpec.describe "destroy an article" do
  let(:current_user) { User.create(name: "Chris", email: "chris@test.com", password: "password") }
  let!(:article) { Article.create(title: "Test title", content: "Test content", author_id: current_user.id, is_published: true, publish_date: Date.today) }

  it "can destroy an article" do
    login_as(current_user)
    visit(articles_path)
    within("#article_1") do
      click_on("Delete")
    end
    expect(current_path).to eq(articles_path)
    expect(page).to have_content("Article deleted!")
    expect { Article.find(article.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
