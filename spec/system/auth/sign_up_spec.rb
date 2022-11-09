# frozen_string_literal: true

require 'rails_helper'

RSpec.describe('Sign up flow', type: :system) do
  let(:email) { 'example@email.com' }
  let(:password) { 'Password123!' }

  scenario 'valid request' do
    visit '/sign_up'
    fill_in 'email', with: email
    fill_in 'password', with: password
    click_on 'sign_up'
    expect(page).to(have_content('Rejestracja pomyslna'))
    expect(page).to(have_current_path('/sign_in'))
    expect(User.count).to(eq(1))
  end

  context 'invalid request' do
    before { create(:user, email: email, password: password) }

    scenario 'user already exists' do
      visit '/sign_up'
      fill_in 'email', with: email
      fill_in 'password', with: password
      click_on 'sign_up'
      expect(page).to(have_content('Cos poszlo nie tak, sprobuj ponownie'))
    end

    scenario 'invalid formated params' do
      visit '/sign_up'
      fill_in 'email', with: 'invalid'
      fill_in 'password', with: 'invalid'
      click_on 'sign_up'
      expect(page).to(have_content('Cos poszlo nie tak, sprobuj ponownie'))
    end
  end
end
