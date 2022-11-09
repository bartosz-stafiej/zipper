# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'siepomaga@email.com' }
    password { 'UltraValidPassword123!' }
  end
end
