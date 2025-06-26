# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { "user@email.com" }
    password { "password" }
  end
end
