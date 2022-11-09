# frozen_string_literal: true

require 'rails_helper'

RSpec.describe('Show all atachments flow', type: :system) do
  let(:email) { 'example@email.com' }
  let(:password) { 'Password123!' }

  context 'when valid request' do
    before do
      user = create(:user, email: email, password: password)
      create_list(:attachment, 11, owner: user)
    end

    scenario 'return valid paginated attachments' do
      visit '/sign_in'
      fill_in 'email', with: email
      fill_in 'password', with: password
      click_on 'login'

      expect(page).to(have_current_path('/attachments'))
      expect(page).not_to(have_content('Previous'))

      expect(all('tr[id="attachment-item"]').size).to(eq(10))

      find('div[id="next"]').click

      expect(page).to(have_content('Previous'))

      expect(all('tr[id="attachment-item"]').size).to(eq(1))
      expect(page).not_to(have_content('next'))
    end
  end

  context 'when invalid request' do
    scenario 'when user unauthorized' do
      visit '/attachments'
      expect(page).to(have_current_path('/sign_in'))
    end
  end
end
