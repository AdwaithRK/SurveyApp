class Users::LoggedInController < ApplicationController
 
 def index
   @survey = current_user.surveys.new
  #  @survey.questions.build
   p current_user
   p @survey
  #  @suvey.questions.build
 end

 def new

 end
 



end
