# Preview all emails at http://localhost:3000/rails/mailers/message_mailer
class MessageMailerPreview < ActionMailer::Preview
  def message
    @message = Message.new(name: "何食べる太郎", email: "sample@gmail.com", content: "問い合わせテストメッセージ")

    MessageMailer.received_email(@message)
  end
end
