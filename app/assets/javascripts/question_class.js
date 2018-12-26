
class Question{
    constructor(){
      this.question = ""
      this.optionCount = 0
      this.options = []
      this.questionType = Text;
    }

    AssignQuesiton(question,questionType){
        this.question = question
        this.questionType = questionType
    }

    AssignOption(options){
        this.optionCount = options.length
        this.options = options
    }

    SaveQuestion(){
        questionArray.push(this)
    }

    GetIndex(){
        return questionArray.indexOf(this)
        
    }

    GetJson(){
        return JSON.stringify(this)
    }
    
}
