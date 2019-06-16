require "rails_helper"

RSpec.describe "signup" do
  it "create a new user" do
    visit(users_signup_path)
    fill_in("Name", with: "Chris Gebhardt")
    fill_in("Email", with: "chris@test.com")
    fill_in("Password", with: "password")
    fill_in("Password confirmation", with: "password")
    click_button("Sign Up")
    expect(current_path).to eq(root_path)
    expect(page).to have_content("Welcome!")
    expect(User.last.email).to eq("chris@test.com")
  end
end
