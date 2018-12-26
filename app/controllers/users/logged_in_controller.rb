class Users::LoggedInController < ApplicationController
 
 def index
  @surveys = current_user.surveys
  p request
  @domain = request.host
 end

 def new

 end
 



end
