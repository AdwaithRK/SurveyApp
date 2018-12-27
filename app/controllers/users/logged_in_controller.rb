class Users::LoggedInController < ApplicationController
 
 def index
  @surveys = current_user.surveys
 end

 def new

 end
 



end
