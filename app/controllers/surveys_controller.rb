require 'csv'
require 'will_paginate/array'
# survey controller
class SurveysController < ApplicationController
  before_action :permit_survey_answer, only: [:create]
  before_action :permit_answer_array, only: [:submit]
  before_action :permit_update_params, only: [:update]
  before_action :authenticate_user!, except: %i[attend submit thanks]
  before_action :find_survey, only: [:attend, :edit, :update, :stats]
  after_action  :redirect_after_survey_submit, only: [:submit]
  before_action :check_question_presence, only: [:submit]

  def create
    current_user.surveys.create(params[:survey])
    redirect_to logged_in_url
  end

  def new; end

  def attend; end

  def edit; end

  def update
    @survey.update(params[:survey])
    redirect_to logged_in_url
  end

  def submit
    attempt_id = Attempt.create(survey_id: params[:survey_id]).id
    answers = Answer.format_question(params[:question_array], params[:survey_id],
                                     params[:user_name], attempt_id, current_user)
    Answer.create(answers)
    #answer = Answer.save(answers)
    #if answer.save
    # unless current_user
    #   redirect_to surveys_thanks_url
    # else
    #   redirect_to logged_in_url
    # end
    # #end
  end

  def thanks; end

  def invite
    UserMailer.with(invitee: params[:invitee], invitor: params[:inviter], email: params[:email], link: params[:link]).invite_email.deliver_now
  end

  def stats
    respond_to do |format|
      format.csv { send_csv(Answer.generate_csv(params[:link])) }
    end
  end

  def stats_survey
    @array = Answer.generates_stats(params[:link])
    if @array.length == 1
      flash[:error] = 'Entries not found.'
      redirect_to '/logged_in'
    end
  end

  def delete
    render json: { msg: 'destroyed' } if Survey.find_by_link(params[:link]).destroy
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

  def permit_update_params
    params.permit!
    #params.permit(:survey, :id)
  end

  def send_csv(csv)
    send_data(csv,
              type: 'text/csv; charset=utf-8; header=present',
              disposition: "attachment; filename=#{@survey.title}_survey_data.csv")
  end

  def find_survey
    link = params[:link] || params[:id]
    @survey = Survey.find_by_link(link)
    # flash.keep
    # redirect_to root_url, flash: { notice: "Record not found." } if @survey.nil?
    if @survey.nil?
      flash[:error] = 'No such survey.'
      if current_user
        redirect_to '/logged_in'
      else
        redirect_to root_url
      end
    end
  end

  def redirect_after_survey_submit
    flash[:notice] = 'Successfully completed survey.'
    redirect_to current_user ? logged_in_path : survey_thanks
  end

  def check_question_presence
    if params[:question_array].nil?
      flash[:error] = 'No question to submit'
      if current_user
        redirect_to '/logged_in'
      else
        redirect_to root_url
      end
    end
  end
end
