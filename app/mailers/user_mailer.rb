class UserMailer < ApplicationMailer

  def invite_email
    @email = params[:email]
    @inviter = params[:inviter]
    @invitee = params[:invitee]
    @link = params[:link]
    mail(to: @email, subject: "Please Attend this survey #{@invitee}")
  end
end
