class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user, optional: true
  belongs_to :survey
  belongs_to :attempt

  def self.format_question(question_array, survey_id, user_name, attempt_id, current_user)
    answers = Array.new()
    user_id = current_user.id if current_user
    question_array.each do |key, value|
      answers.push({question_id: value[:question_id], survey_id: survey_id, attempt_id: attempt_id, answer: value[:answer_text], user_id: user_id, user_name: user_name})
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

  def self.generates_stats(link)
    @survey = Survey.find_by_link(link)
    @questions = @survey.questions
    answer = []
    answer << question_header()
    generate_csv_row { |value| answer << value }
    answer
  end

  def self.generate_csv_row
    grouped_answers = Answer.where(survey_id: @survey.id).includes(:user)
                            .group_by(&:attempt_id)
    csv_array = []
    grouped_answers.each do |_key, value|
      user_name = value[0].user&.firstname || value[0].user_name
      @question_id_array.each do |question_id|
        value.each do |answer|
          answer.question_id == question_id && csv_array.push(answer.answer)
        end
      end
      user_name = 'guest user' if user_name.nil? || user_name.empty?
      csv_array.unshift(user_name)
      yield csv_array
      csv_array = []
    end
  end

  def self.question_header
    # question_array = []
    # @question_id_array = []
    # question_array.push('')
    # @questions.each do |question|
    #   question_array.push(question.question)
    #   @question_id_array.push(question.id)
    # end
    # question_array


    records = @questions.pluck(:question, :id)
    @questions_array = records.map(&:first)
    @questions_array.unshift('username')
    @question_id_array = records.map(&:second)
    @questions_array
  end

end
