require "support/login_helper"
require 'rails_helper'

RSpec.configure do |c|
  c.include LoginHelper
end

RSpec.describe 'authentication' do
  let(:current_user) { User.create(id: 1, name: 'Chris', email: 'chris@test.com', password: 'password') }

  describe 'sign in' do
    context 'sing in with wrong password' do
      it 'cannot create a new session with wrong password' do
        visit new_session_path
        fill_in('Email', with: current_user.email)
        fill_in('Password', with: 'wrong' + current_user.password)
        click_button('Login')
        expect(current_path).to eq(new_session_path)
        expect(page).to have_content('Email or password is invalid')
        expect(page.get_rack_session[:user_id]).to be nil
      end

      it 'cannot create a new session with non-existent user' do
        visit new_session_path
        fill_in('Email', with: 'non-exist' + current_user.email)
        fill_in('Password', with: current_user.password)
        click_button('Login')
        expect(current_path).to eq(new_session_path)
        expect(page).to have_content('Email or password is invalid')
        expect(page.get_rack_session[:user_id]).to be nil
      end

      context 'sign in successfully with correct email and password' do
        it 'create a new session' do
          visit new_session_path
          fill_in('Email', with: current_user.email)
          fill_in('Password', with: current_user.password)
          click_button('Login')
          expect(current_path).to eq(root_path)
          expect(page.get_rack_session_key('user_id')).to eq current_user.id
        end
      end
    end
  end

  describe 'sign out' do
    it 'delete a session' do
      login_as(current_user)
      expect(current_path).to eq(root_path)
      expect(page).to have_content('Log out')

      click_on('Log out')
      expect(current_path).to eq(new_session_path)
      expect(page).to have_content('Logged out!')
      expect(page.get_rack_session[:user_id]).to be nil
    end
  end
end
