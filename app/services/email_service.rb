class EmailService
  def self.send_email(agreement)
    puts agreement.inspect
    mail = Mail.new do
      from    'romulo.fortaleza@tjce.jus.br'
      #message_id 'paulo.guilherme@tjce.jus.br'
      to       agreement.email
      subject  "SIN-Certifique-se"
      #body File.read('app/views/certificate_mailer/send_certificate.html.erb')
     # if  File.file?(log_path) then
      #  add_file log_path
     #end
     html_part do
    content_type 'text/html; charset=UTF-8'
    url = "http://localhost:3000/agreements/#{agreement.id}/export"
    body "<p> Olá #{agreement.client_name}, seu certificado está pronto, <a href='#{url}'>acesse aqui</a> para baixar ou imprimir.</p>"  end
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
