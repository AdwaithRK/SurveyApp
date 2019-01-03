require 'csv'
# survey controller
class SurveysController < ApplicationController
  before_action :permit_survey_answer, only: [:create]
  before_action :permit_answer_array, only: [:submit]
  before_action :authenticate_user!, except: [:attend, :submit, :thanks]

  def create
    current_user.surveys.create(params[:survey])
    redirect_to logged_in_url
  end

  def new; end

  def attend
    @survey = Survey.find_by_link(params[:link])
  end

  def submit
    attempt_id = Attempt.create(survey_id: params[:survey_id]).id
    answers = Answer.format_question(params[:question_array], params[:survey_id], attempt_id, current_user)
    Answer.create(answers)
    #answer = Answer.save(answers)
    #if answer.save
    unless current_user
      redirect_to surveys_thanks_url
    else
      redirect_to logged_in_url
    end
    #end
  end

  def thanks; end

  def invite
    UserMailer.with(invitee: params[:invitee], invitor: params[:inviter], email: params[:email], link: params[:link]).invite_email.deliver_now
  end

  def stats
    @survey = Survey.find_by_link(params[:link])
    respond_to do |format|
      format.js
      format.csv { send_csv(Answer.generate_csv(params[:link])) }
    end
  end

  private

  def permit_answer_array
    # params.permit(:survey_id, question_array: [:question_id, :answer_text])
    params.permit!
  end

  def permit_survey_answer
    # params.permit(survey: [:title, :description, :questions_attributes])
    params.permit!
  end

  def send_csv(csv)
    send_data(csv,
              type: 'text/csv; charset=utf-8; header=present',
              disposition: "attachment; filename=#{@survey.title}_survey_data.csv")
  end

end