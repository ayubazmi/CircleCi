# frozen_string_literal: true

require "rails_helper"

RSpec.describe Devise::SessionsController, type: :controller do
  it { is_expected.to route(:get, "/users/sign_in").to(action: :new) }
  it { is_expected.to route(:post, "/users/sign_in").to(action: :create) }
  it { is_expected.to route(:delete, "/users/sign_out").to(action: :destroy) }
end
