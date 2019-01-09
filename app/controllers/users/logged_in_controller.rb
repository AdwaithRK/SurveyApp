class Users::LoggedInController < ApplicationController

  before_action :authenticate_user!
  def index
    @surveys = current_user.surveys.paginate(page: params[:page], per_page: 5)
  end

  def new

  end
end
