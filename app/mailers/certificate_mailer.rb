class CertificateMailer < ApplicationMailer
  default from: "jaopinto92@gmail.com"

  def send_certificate(user_id)
    @agreement = Agreement.find(user_id)
    mail(:to => "ramf08@gmail.com", :subject => "teste")
  end
end
