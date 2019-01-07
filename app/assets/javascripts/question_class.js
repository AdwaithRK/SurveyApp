
class Question {
    constructor() {
        this.question = ""
        this.optionCount = 0
        this.options = []
        this.questionType = "text"
        this.has_options = false
    }

    AssignQuesiton(question, questionType) {
        this.question = question
        this.questionType = questionType
        if (questionType != "text") this.has_options = true
    }

    AssignOption(options) {
        this.optionCount = options.length
        this.options = options
    }

    ReplaceOption(oldOption, newOption) {
        var optionIndex = this.options.indexOf(oldOption)
        this.options[optionIndex] = newOption
    }

    ChangeQuestion(question) {
        this.question = question
    }

    SaveQuestion() {
        questionArray.push(this)
    }

    GetIndex() {
        return questionArray.indexOf(this)
    }

    GetJson() {
        return JSON.stringify(this)
    }

}
