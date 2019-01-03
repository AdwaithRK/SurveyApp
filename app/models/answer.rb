class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user, optional: true
  belongs_to :survey
  belongs_to :attempt

  def self.format_question(question_array, survey_id, attempt_id,current_user)
    answers = Array.new()
    user_id = current_user.id if current_user
    question_array.each do |key, value|
      answers.push({question_id: value[:question_id], survey_id: survey_id, attempt_id: attempt_id, answer: value[:answer_text], user_id: user_id})
    end
    answers
  end

  def self.generate_csv(link)
    @survey = Survey.find_by_link(link)
    @questions = @survey.questions
    CSV.generate do |csv|
      csv << ['Survey', @survey.title]
      csv << question_header()
      generate_csv_row { |row| csv << row }
    end
  end

  def self.generate_csv_row
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

  def self.question_header
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
