require "generate_pdf"
class AgreementMailer < ActionMailer::Base

  include GeneratePdf

  def gen_pdf

    mail.attachments[agreement.pdf] = {:mime_type => "application/pdf", :content => generate_pdf}

    mail(
      :to => "ramf@tjce.com",
      :from => "ramf08@gmail.com"
      :subject => "Certificado criado com sucesso e enviado para o e-mail cadastrado."
    )
  end
end
