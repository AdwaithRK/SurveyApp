class SurveysController < ApplicationController
  def create
    # p 'here in create'
    params.permit!
    current_user.surveys.create(params[:survey])
  end
  
  def new 
  end

  def attend
    @survey = Survey.find_by_link(params[:link])
  end

  def submit
    p "here in submit"
    p params[:question_array]
  end

end
