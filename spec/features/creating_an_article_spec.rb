require "support/login_helper"
require "rails_helper"

RSpec.configure do |c|
  c.include LoginHelper
end

RSpec.describe "create an article" do
  let(:current_user) { User.create(name: "Chris", email: "chris@test.com", password: "password") }

  it "can save and display an article" do
    login_and_visit_new_article_path
    fill_in("Title", with: "Test title")
    check("Is published")
    fill_in("Publish date", with: "2019-06-15")
    fill_in("Content", with: "Content")
    click_button("Save")
    expect(current_path).to eq(articles_path)

    within("#article_1") do
      expect(page).to have_selector(".title", text: "Test title")
      expect(page).to have_selector(".views-count", text: "0")
      expect(page).to have_selector(".author", text: current_user.name)
      expect(page).to have_selector(".publish-date", text: "2019-06-15")
    end
  end

  it "displays any errors on page" do
    login_and_visit_new_article_path
    click_button("Save")
    expect(page).to have_content("New Article")
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Content can't be blank")
  end

  def login_and_visit_new_article_path
    login_as(current_user)
    visit(articles_path)
    click_on("New")
    expect(current_path).to eq(new_article_path)
  end
end
