class SurveysController < ApplicationController
  def create
    p 'here in create'
    current_user.surveys.create(params[:survey])
  end
  
  def new 
  end
end
