class MessageMailer < ApplicationMailer
  default  to: ENV['G_MAIL']

  def received_email(message)
    @message = message
    mail(subject: 'webサイトよりメッセージが届きました') do |format|
      format.text
    end
  end
end
