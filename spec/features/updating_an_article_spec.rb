require "support/login_helper"
require "rails_helper"

RSpec.configure do |c|
  c.include LoginHelper
end

RSpec.describe "update an article" do
  let(:current_user) { User.create(name: "Chris", email: "chris@test.com", password: "password") }
  let(:article) { Article.create(title: "Test title", content: "Test content", author_id: current_user.id, is_published: true, publish_date: Date.today) }

  it "can update an article" do
    login_and_visit_edit_article_path(article)
    fill_in("Title", with: "Updated title")
    check("Is published")
    fill_in("Publish date", with: "2019-07-15")
    fill_in("Content", with: "Updated Content")
    click_button("Save")
    expect(current_path).to eq(articles_path)

    within("#article_1") do
      expect(page).to have_selector(".title", text: "Updated title")
      expect(page).to have_selector(".publish-date", text: "2019-07-15")
    end
  end

  def login_and_visit_edit_article_path(article)
    login_as(current_user)
    visit(articles_path)
    within("#article_#{article.id}") do
      click_on("Edit")
    end
    expect(current_path).to eq(edit_article_path(article))
  end
end

