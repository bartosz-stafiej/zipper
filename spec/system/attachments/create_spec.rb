# frozen_string_literal: true

require 'rails_helper'

RSpec.describe('Create attachment flow', type: :system) do
  let(:email) { 'example@email.com' }
  let(:password) { 'Password123!' }

  context 'when valid request' do
    before do
      create(:user, email: email, password: password)
    end

    scenario 'creates attachment' do
      visit '/sign_in'
      fill_in 'email', with: email
      fill_in 'password', with: password
      click_on 'login'

      expect(page).to(have_current_path('/attachments'))

      click_on 'Dodaj Plik'

      expect(page).to(have_current_path('/attachments/new'))

      find('input[class="hidden"]', visible: false).attach_file('spec/support/files/file_helper.png')

      click_on 'Stworz Plik'
      expect(page).to(have_current_path('/attachments'))
      expect(page).to(have_content('Utworzono plik pomyslnie'))
    end
  end

  context 'when invalid request' do
    scenario 'when user unauthorized' do
      visit '/attachments/new'
      expect(page).to(have_current_path('/sign_in'))
    end
  end
end
