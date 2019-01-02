class Users::LoggedInController < ApplicationController

  before_action :authenticate_user!
  def index
    @surveys = current_user.surveys
  end

  def new

  end
end
