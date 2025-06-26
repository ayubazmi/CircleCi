# frozen_string_literal: true

require "rails_helper"

RSpec.describe TasksController, type: :controller do
  describe "routing" do
    it { is_expected.to route(:get, "/tasks").to(action: :index) }
    it { is_expected.to route(:get, "/tasks/1").to(action: :show, id: "1") }
    it { is_expected.to route(:post, "/tasks").to(action: :create) }
    it { is_expected.to route(:put, "/tasks/1").to(action: :update, id: "1") }
    it { is_expected.to route(:patch, "/tasks/1").to(action: :update, id: "1") }
    it { is_expected.to route(:delete, "/tasks/1").to(action: :destroy, id: "1") }
  end
end
