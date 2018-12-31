class SurveysController < ApplicationController

  before_action :permit_survey_answer, only: [:create]
  before_action :permit_answer_array, only: [:submit]

  def create
    current_user.surveys.create(params[:survey])
  end

  def new
  end

  def attend
    @survey = Survey.find_by_link(params[:link])
  end

  def submit
    p params[:question_array]
    attempt_id = Attempt.create(survey_id: params[:survey_id]).id
    answers = format_question(params[:question_array], params[:survey_id], attempt_id)
    Answer.create(answers)
  end

  def stats
    @survey = Survey.find_by_link(params[:link])
  end

  private

  def format_question(question_array,survey_id, attempt_id)
    answers = Array.new()
    question_array.each do |key, value|
      answers.push({question_id: value[:question_id], survey_id: survey_id, attempt_id: attempt_id, answer: value[:answer_text]})
    end
    answers
  end

  def permit_answer_array
    params.permit(:survey_id, question_array: [:question_id, :answer_text])
  end

  def permit_survey_answer
    params.permit(survey: [:title, :description, :questions_attributes])
  end

end
