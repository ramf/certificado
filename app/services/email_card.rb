class EmailCard
  def self.send_card(certificate)
    puts certificate.inspect
    mail = Mail.new do
      from    'romulo.fortaleza@tjce.jus.br'
      #message_id 'paulo.guilherme@tjce.jus.br'
      to       certificate.email
      subject  "SIN-Certifique-se"

      add_file 'public/certificate.pdf'
      #body File.read('app/views/certificate_mailer/send_certificate.html.erb')
     # if  File.file?(log_path) then
      #  add_file log_path
     #end
     html_part do
      content_type 'text/html; charset=UTF-8'
      url = "http://localhost:3000/certificates/#{certificate.id}/export"
      body "<p> Olá #{certificate.name}, seu certificado está pronto! Clique no PDF em anexo para baixar.</p>"
     end
  end
    puts mail.to_s
    mail.delivery_method :smtp, { address: "webmail.tjce.jus.br",
      port: 25,
      openssl_verify_mode: "none",
      user_name: '900828',
      password: 'ramf2',
      authentication: 'login',
      enable_starttls_auto: true
}
    mail.deliver
  end
end
