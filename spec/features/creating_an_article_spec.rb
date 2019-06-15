require "support/login_helper"
require "rails_helper"

RSpec.configure do |c|
  c.include LoginHelper
end

RSpec.describe "create an article" do
  let(:current_user) { User.create(name: "Chris", email: "chris@test.com", password: "password") }

  it "can save and display an article" do
    login_as(current_user)
    visit(articles_path)
    click_on("New")
    expect(current_path).to eq(new_article_path)

    fill_in("Title", with: "Test title")
    check("Is Published")
    fill_in("Publish Date", with: "2019/06/15")
    fill_in("Content", with: "Content")
    click_button("Save")
    expect(current_path).to eq(articles_path)

    within("#article_1") do
      expect(page).to have_selector(".title", text: "Test title")
      expect(page).to have_selector(".views-count", text: "0")
      expect(page).to have_selector(".author", text: current_user.name)
      expect(page).to have_selector(".publish-date", text: "2019/6/15")
    end
  end
end