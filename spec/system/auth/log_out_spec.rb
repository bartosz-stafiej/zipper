# frozen_string_literal: true

require 'rails_helper'

RSpec.describe('Log out flow', type: :system) do
  let(:email) { 'example@email.com' }
  let(:password) { 'Password123!' }

  before(:each) do
    create(:user, email: email, password: password)
  end

  scenario 'valid request' do
    visit '/sign_in'
    fill_in 'email', with: email
    fill_in 'password', with: password
    click_on 'login'
    expect(page).to(have_current_path('/attachments'))

    find('li[id="logout"]').click

    expect(page).to(have_current_path('/sign_in'))
  end
end
