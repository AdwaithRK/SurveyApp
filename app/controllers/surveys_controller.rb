require 'csv'
# survey controller
class SurveysController < ApplicationController
  before_action :permit_survey_answer, only: [:create]
  before_action :permit_answer_array, only: [:submit]
  before_action :authenticate_user!, except: [:attend, :submit, :thanks]

  def create
    current_user.surveys.create(params[:survey])
  end

  def new; end

  def attend
    @survey = Survey.find_by_link(params[:link])
  end

  def submit
    attempt_id = Attempt.create(survey_id: params[:survey_id]).id
    answers = format_question(params[:question_array], params[:survey_id], attempt_id)
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

  def stats
    @survey = Survey.find_by_link(params[:link])
    @count_attendentees = @survey.attempts.count
    @questions = @survey.questions
    respond_to do |format|
      format.js
      format.csv { send_csv(generate_csv) }
    end
  end

  private

  def format_question(question_array, survey_id, attempt_id)
    answers = Array.new()
    user_id = current_user.id if current_user
    question_array.each do |key, value|
      answers.push({question_id: value[:question_id], survey_id: survey_id, attempt_id: attempt_id, answer: value[:answer_text], user_id: user_id})
    end
    answers
  end

  def permit_answer_array
    params.permit(:survey_id, question_array: [:question_id, :answer_text])
  end

  def permit_survey_answer
    params.permit(survey: [:title, :description, :questions_attributes])
  end

  def send_csv(csv)
    send_data(csv,
              type: 'text/csv; charset=utf-8; header=present',
              disposition: "attachment; filename=#{@survey.title}_survey_data.csv")
  end

  def generate_csv
    CSV.generate do |csv|
      csv << ['Survey', @survey.title]
      csv << question_header
      generate_csv_row { |row| csv << row }
    end
  end

  def generate_csv_row
    grouped_answers = Answer.where(survey_id: @survey.id).includes(:user).group_by(&:attempt_id)
    csv_array = []
    grouped_answers.each do |_key, value|
      user_name = value[0].try(:user).try(:firstname)
      @question_id_array.each do |question_id|
        value.each do |answer|
          csv_array.push(answer.answer) if answer.question_id == question_id
        end
      end
      user_name = 'guest user' if user_name.nil?
      csv_array.unshift(user_name)
      yield csv_array
      csv_array = []
    end
  end

  def question_header
    question_array = []
    @question_id_array = []
    question_array.push('')
    @questions.each do |question|
      question_array.push(question.question)
      @question_id_array.push(question.id)
    end
    question_array
  end

end