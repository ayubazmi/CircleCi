# frozen_string_literal: true

require "rails_helper"

RSpec.describe Devise::PasswordsController, type: :controller do
  it { is_expected.to route(:get, "/users/password/new").to(action: :new) }
  it { is_expected.to route(:get, "/users/password/edit").to(action: :edit) }
  it { is_expected.to route(:post, "/users/password").to(action: :create) }
  it { is_expected.to route(:put, "/users/password").to(action: :update) }
  it { is_expected.to route(:patch, "/users/password").to(action: :update) }
end
