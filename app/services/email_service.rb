class EmailService
  def self.send_email(from, to, subject, path)
    mail = Mail.new do
      from    'paulo.guilherme@tjce.jus.br'
      message_id 'paulo.guilherme@tjce.jus.br'
      to       "filipe.botti@ctis.com.br"
      subject  "Teste"
      body "simple body"
     # if  File.file?(log_path) then
      #  add_file log_path
     #end
    end
    puts mail.to_s
    mail.delivery_method :smtp, { address: "webmail.tj.ce.gov.br", port: 25, openssl_verify_mode: "none", 
      user_name: '601141', password: 'alohomora', authentication: 'plain',
      enable_starttls_auto: true
    }
    mail.deliver
  end
end
