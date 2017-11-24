class CertificateMailer < ApplicationMailer
  default from: "jaopinto92@gmail.com"

  def send_certificate(user_id)
    @agreement = Agreement.find(user_id)
    mail(:to => "romulo.fortaleza@tjce.jus.br", :subject => "teste")
  end
end
