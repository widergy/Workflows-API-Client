class DummyFatherController < ApplicationController
  before_action :authenticate_request

  def authenticate_request; end

  def current_user; end
end
